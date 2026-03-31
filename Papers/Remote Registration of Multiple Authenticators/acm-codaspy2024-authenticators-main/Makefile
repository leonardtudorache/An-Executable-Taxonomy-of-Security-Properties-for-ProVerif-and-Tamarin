
N_Auth := 3

verify_duplicate:
	@time -p sh -c '\
		eval $$(opam env) && \
		python3 expand.py -i auth_dup.pve -o auth_dup_${N_Auth}.pv -r "i<${N_Auth}" && \
		proverif auth_dup_${N_Auth}.pv && \
		echo "Benchmark for $(N_Auth) duplicate authenticators:" \
	'

verify_proxy:
	@time -p sh -c '\
		eval $$(opam env) && \
		python3 expand.py -i auth_proxy.pve -o auth_proxy_${N_Auth}.pv -r "i<${N_Auth}" && \
		proverif auth_proxy_${N_Auth}.pv && \
		echo "Benchmark for $(N_Auth) proxy authenticators:" \
	'

verify_ring:
	@time -p sh -c '\
		eval $$(opam env) && \
		python3 expand.py -i auth_ring.pve -o auth_ring_${N_Auth}.pv -r "i<${N_Auth}" && \
		proverif auth_ring_${N_Auth}.pv && \
		echo "Benchmark for $(N_Auth) ring authenticators:" \
	'
