# R-Ladies MTL October 2023 Exercises

# Hint: Use `?` to get help for any of the functions, e.g.;
# ?length

# 1. Install the Bioconductor package Biostrings .
install.packages("BiocManager")
BiocManager::install("Biostrings")

# 2. Store at least 2 DNA sequences in a DNAStringSet object.
library(Biostrings)
# GCTA
dna <- c("CTGTGC", "TGA", "CCT")
dna_new <- DNAStringSet(dna)

dna1 <- DNAString("TG")
dna2 <- DNAString("GCGC")
dna_new2 <- DNAStringSet(list(dna1, dna2))

# 3. Translate your DNA into amino acids.
# Bonus 1: Try incorporating ambiguous bases in your DNA. Test different if.fuzzy.codon options of translate().
translate(DNAStringSet(dna))

aas <- translate(dna_new)
translate(DNAString("TGAHGA"), if.fuzzy.codon = "solve")

# 4. Count the number of methionine (M) residues in each sequence.
# (If you have no methionine, try a different amino acid!)
# Bonus 2: Summarize the distribution across all of your sequences.
counts <- alphabetFrequency(aas)

df <- data.frame(counts)
df$M
summary(df$M)


