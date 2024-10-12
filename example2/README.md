These files were produced with

for alg in enum_pred sieve_pred; do
  for m in {56..64}; do
    docker run -ti --rm -v bdd-predicate:/bdd-predicate -w /bdd-predicate martinralbrecht/bdd-predicate sage -python ecdsa_cli.py benchmark -n 521 -k 512 -m $m -a $alg -t 1024 -j 256
  done
done

The HNP solver is https://github.com/malb/bdd-predicate as described in

Martin R. Albrecht and Nadia Heninger
On Bounded Distance Decoding with Predicate: Breaking the "Lattice Barrier" for the Hidden Number Problem

Note that enum_pred/56 did not complete and was terminated after 70.5 days. Its number of successes are:

$ grep 'success: 1' bdd-enum_pred-56.out |wc -l
443

Which is a success rate >= 443/1024 = 0.43

