# Remote Registration of Multiple Authenticators

**Authors:** Yongqi Wang, Thalia Laing, José Moreira, Mark D. Ryan

CODASPY'24: Proceedings of the Fourteenth ACM Conference on Data and Application Security and Privacy, June 19-21, 2024, Porto, Portugal, https://doi.org/10.1145/3626232.3653273

## Requirements

- [Python](https://www.python.org/downloads/) `>= 3.0`
- [ProVerif](https://bblanche.gitlabpages.inria.fr/proverif/) `>= 2.05`

## File summary

Utils:

- `expand.py`: Macro preprocessor - parses [extended ProVerif code](#extension-to-proverif-syntax) to regular ProVerif code.
- `Makefile`: Makefile for benchmarks.

Templates:

- `auth_dup.pve`: Extended ProVerif file for duplicate authenticators.
- `auth_proxy.pve`: Extended ProVerif file for proxy authenticators.
- `auth_ring.pve`: Extended ProVerif file for ring authenticators.

Concrete instantiations:

- `auth_dup_3.pv`: ProVerif file for three duplicate authenticators.
- `auth_proxy_3.pv`: ProVerif file for three proxy authenticators.
- `auth_ring_3.pv`: ProVerif file for three ring authenticators.

## Examples of usage

The examples below generate and verify models for `N_Auth=3` authenticators per user.

- Duplicate authenticators:

  ```bash
  python expand.py -i auth_dup.pve -o auth_dup_3.pv -r "i<3"
  proverif auth_dup_3.pv
  ```

- Proxy authenticators:

  ```bash
  python expand.py -i auth_proxy.pve -o auth_proxy_3.pv -r "i<3"
  proverif auth_proxy_3.pv
  ```

- Ring authenticators:

  ```bash
  python expand.py -i auth_ring.pve -o auth_ring_3.pv -r "i<3"
  proverif auth_ring_3.pv
  ```

**Note:** In order to obtain a full report in HTML format, we recommend to create a sub-directory within the working directory, e.g., `mkdir <dir_name>`, and use ProVerif with the command line option `-html <dir_name>`. See further command line options in the [ProVerif manual](https://bblanche.gitlabpages.inria.fr/proverif/manual.pdf).

## Comments on the models

The models consider scenarios with an arbitrary number of users, each with a fixed number `N_Auth` of authenticators, and an arbitrary number of relying parties.

### Notation

The following notation is used for objects in the `.pve`/`.pv` files:

- `uid`:  User ID (identifies a particular authenticator set).
- `RPj`:  Unique identifier of relying party *j*.
- `k`:    A strong secret shared by all the authenticators.
- `L`:    A list of public keys.
- `Lj`:   A list of public keys associated with relying party *RPj*.
- `regChal`: Registration challenge.
- `authChal`: Authentication challenge.
- (`xi`, `yi`):   A primary keypair belonging to authenticator *Ai*.
- (`xij`, `yij`):   A derived keypair belonging to authenticator *Ai*.

### Extension to ProVerif syntax

To accommodate an arbitrary (but finite) number of authenticators, we have developed an extension to the ProVerif syntax that expands a block of code into a specified number of repetitions, in our case the number of authenticators `N_auth` per user. The extension syntax is:

``` text
{<prefix>$<var_name_>;<suffix>}
```

or

``` text
{<prefix>$<var_name_>;<suffix>/<separator>}
```

where `<prefix>` and `<suffix>` are constant strings, `<var_name>` is the name of the variable to be substituted, and `<separator>` is the string inserted between substitutions (defaulting to `, ` if unspecified). This syntax allows to parameterize ProVerif constructs.

The macro preprocessor expand.py processes extended Proverif files (`.pve`) and outputs regular ProVerif files (`.pv`). Example of usage considering variables `i=3` and `j=2`:

``` bash
python expand.py -i myfile.pve -o myfile.pv -r "i<3,j<2"
```

| Syntax in the .pve file     | Expansion in the .pv file                      |
| --------------------------- | ---------------------------------------------- |
| `f({x$i;z})`                | `f(x1z, x2z, x3z)`                             |
| `{foo$i;/ + }`              | `foo1 + foo2 + foo3`                           |
| `{f(y$j;, g({x$i;}))/ && }` | `f(y1, g(x1, x2, x3)) && f(y2, g(x1, x2, x3))` |
| `{f(x$j;+y$j;)}`            | `f(x1+y1), f(x2+y2)`                           |

Features and limitations:

- List definitions can be nested.
- A single variable, e.g., `$i;`, can be repeated multiple times within the scope of a list definition.
- Different variables, e.g., `$i;` and `$j;` cannot coexist in the same list definition.
- ProVerif block comments must be used to repeat a constant value, e.g., `f({(*$i;*)k})` will produce `f((*1*)k, (*2*)k, (*3*)k)`

## Benchmark

Benchmark obtained with ProVerif v2.05 on an Intel(R) Core(TM) i7-1165G7 @ 2.80GHz x 8 processor, and 16 Gb RAM.

| **`N_Auth`**     |   **Duplicate** |     **Proxy** |    **Ring** |
|--------------:|----------------:|--------------:|------------:|
|             2 |      0m  0.089s |    0m  0.242s |  0m  0.181s |
|             3 |      0m  0.121s |    0m  5.036s |  0m  0.456s |
|             4 |      0m  0.141s |    7m 43.905s |  0m  7.116s |
|             5 |      0m  0.182s |    -m  -.---s | 23m 40.121s |
|             6 |      0m  0.236s |    -m  -.---s |  -m  -.---s |

## License


The contents of this repository are licensed under a [Creative Commons Attribution-ShareAlike 4.0 International License][cc-by-sa].

This software is provided "as is," with no warranties of any kind. The authors assume no responsibility for any damages or issues that may arise from using this software.

[![CC BY-SA 4.0][cc-by-sa-shield]][cc-by-sa]

[![CC BY-SA 4.0][cc-by-sa-image]][cc-by-sa]

[cc-by-sa]: http://creativecommons.org/licenses/by-sa/4.0/
[cc-by-sa-image]: https://licensebuttons.net/l/by-sa/4.0/88x31.png
[cc-by-sa-shield]: https://img.shields.io/badge/License-CC%20BY--SA%204.0-lightgrey.svg