# dnaHash
A quick and dirty DNA hashing algorithm

# Usage

```
dnaHash.pl: hashes DNA with a unique algorithm
  Usage: dnaHash.pl [options] file1.fasta...
  --help   This useful help menu
```

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

## Campylobacter cgMLST

Some quick tests on the Campylobacter cgMLST scheme show that there are collisions in 973 out of 2794 loci.
In 684 of those loci, there are at least three alleles that collide.

| at least X | number of loci with collisions in Campylobacter wgMLST database |
|------------|--------------------------------|
| 2          | 973 |
| 3          | 684 |
| 4          | 472 |
| 5          | 292 |
| 6          | 158 |
| 7          | 88  |
| 8          | 49  |
| 9          | 25  |
| 10         | 17  |
| 11         | 10  |
| 12         | 5   |
| 13         | 2   |
| 14         | 2   |
| 15         | 2   |
| 16         | 2   |
| 17         | 2   |
| 18         | 1   |
| 19         | 0   |
| 20         | 0   |

## Salmonela 7-gene MLST

No collisions found for this scheme

## Salmonella wgMLST database

contains 8558 loci

| at least X | number of loci with collisions in Salmonella wgMLST database |
|------------|--------------------------------|
| 2          | 4628 |
| 3          | 4006 |
| 4          | 3741 |
| 5          | 3741 |
| 6          | 3566 |
| 7          | 3437 |
| 8          | 3334 |
| 9          | 3217 |
| 10         | 3072 |
| 11         | 2542 |
| 12         | 2389 |
| 13         | 2253 |
| 14         | 2109 |
| 15         | 1961 |
| 16         | 1828 |
| 17         | 1705 |
| 18         | 1599 |
| 19         | 1468 |
| 20         | 1314 |

