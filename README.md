# dnaHash
A quick and dirty DNA hashing algorithm

# Usage

dnaHash.pl: hashes DNA with a unique algorithm
  Usage: dnaHash.pl [options] file1.fasta...
  --help   This useful help menu


# Algorithm

1. Creates an alphabet of nucleotides, in alphabetical order. 
Add in the rest of the alphabet for a total of 26 characters.
Then, extracts `A`, `C`, `G`, and `T` and moves them to the front of the order.
2. Associates a power of 2 to each letter, in order. These are the flags for each nucleotide.
E.g., A=>1, ... T=>4, B=>8, D=>16,...Z=>33554432
3. For each letter of the DNA sequence, multiplies the base-1 position against the flag.
4. The hash is the product-sum of the sequence

# Examples

| Sequence | hash |
|----------|------|
| A        | 1    |
| C        | 2    |
| AT       | 17   |
| ATG      | 29   |

# Advantages

Fast and straightforward

# Disadvantages

Collisions will be frequent.
Some quick tests on the Campylobacter cgMLST scheme show that there are collisions in 973 loci out of 2794.

