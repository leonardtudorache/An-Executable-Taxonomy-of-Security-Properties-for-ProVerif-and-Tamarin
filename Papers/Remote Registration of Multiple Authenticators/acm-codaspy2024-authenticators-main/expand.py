# -*- coding: utf-8 -*-
"""
Expands an extended ProVerif file (.pve) into a regular ProVerif file (.pv)
"""

from argparse import ArgumentParser
import re
import warnings
from timeit import default_timer as timer


def main() -> None:
    '''Expands an extended ProVerif file (.pve) into a regular ProVerif file (.pv)'''
    start_t = timer()

    print("========================================")
    print("Starting .pve expansion...")
    print("")

    # Parse command line arguments
    parser = ArgumentParser(description="Expands an extended ProVerif file (.pve) into a regular ProVerif file (.pv).")
    parser.add_argument('--inputfile', '-i', help='Input file', type=str, required=True)
    parser.add_argument('--outputfile', '-o', help='Output file', type=str, default='', required=True)
    parser.add_argument('--ranges', '-r', help='Ranges for variables', type=str, default='i<3')
    parser.add_argument('--verbose', '-v', action='store_true')
    args = parser.parse_args()

    if args.outputfile == '':
        args.outputfile = args.inputfile.replace(".pve", ".pveout.pv")

    print(f"Input file:  {args.inputfile}")
    print(f"Output file: {args.outputfile}")

    # Read input file
    with open(args.inputfile, "r", encoding="UTF-8") as f:
        prog = f.read()

    # Gather var ranges in a map
    vars_range = {}
    for r in args.ranges.split(","):
        try:
            r = r.strip()
            range_var = r[0]
            assert (r[1] == "<")
            range_max = int(r[2:])
            vars_range[range_var] = range_max
            if args.verbose:
                print(f"Range for {range_var} is 0..{range_max}")
        except Exception as exc:
            raise Exception(f"Error: the range declaration looks wrong range: {r} ranges string: {args.ranges}") from exc

    # Substitute sets e.g., {f(x&i;j)} --> f(x1j), f(x2j), f(x3j)
    list_pattern = re.compile("\{([^\{\}]*?)(\/.*?)?\}", re.DOTALL)

    while True:
        m = list_pattern.search(prog)

        if not m:
            break

        if m.group(2) is None:
            join_string = ', '
        else:
            join_string = m.group(2)[1:]

        var_pattern = re.compile("\$([a-zA-Z]+?);", re.DOTALL)
        found_vars = var_pattern.findall(m.group(1))

        if len(set(found_vars)) > 1:
            raise Exception(f'Multiple variables in the list definition "{m.group()}".')
        elif len(set(found_vars)) == 0:
            warnings.warn(f'No variables in the list definition "{m.group()}". Expansion will be empty.')
            expansion = ""
        else:
            var_name = found_vars[0]
            if var_name not in vars_range:
                raise Exception(f'Undefined range for variable "{var_name}" in the list definition "{m.group()}".')

            expansion = join_string.join([var_pattern.sub(str(i), m.group(1)) for i in range(1, vars_range[var_name]+1)])

        if args.verbose:
            print("List found: " + str(m.group()))
            print("Expansion: " + str(expansion))
            print()

        prog = prog[:m.start()] + expansion + prog[m.end():]

    # Write output file
    if args.verbose:
        print("Output file contents: " + args.outputfile)
        print(prog)
        print()

    with open(args.outputfile, "w", encoding="utf-8") as f:
        f.write(prog)

    end_t = timer()
    print("")
    print("Done")
    print(f"Time elapsed: {str(end_t-start_t)}")
    print("========================================")


if __name__ == "__main__":
    main()
