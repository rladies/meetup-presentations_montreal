### Data Cleaning in R

### Etape cruciale de tous processus d'analyse de donnees
# Generalement en 3 etapes:

# 1. Exploration des donnees
# 2. Formatage des donnees
# 3. Preparation des donnees pour l'analyse

### Importer les donnees
# Contient diverses variables sur la meteo de Montreal, modifie pour la demontration
library(readxl)
### Changer le repertoire au besoin
setwd("C:/Users/Utilisateur/Documents/R")
weather <- read_excel("RLadies_Dataset_11182018.xlsx")

### Exploration des donnees
# Dimension
dim(weather)

# Structure
str(weather)

# Le package dplyr offre une autre possibilite, glimpse()
library(dplyr)
glimpse(weather)

# Voir les premieres colonnes
head(weather)

# Voir les dernieres colonnes, en  specifiance le nombre de lignes voulues
tail(weather, n = 2)

# Voir le jeu de donnees entier
# Pas conseiller pour les jeux de donnees de grande taille
print(weather)

# Produire un resume
summary(weather)

# Visualiser rapidement les donnees
hist(weather$X_1)
plot(weather$X_2)


### Formatage des donnees
# Principe du tidy data: chaque ligne correspond a une observation, chaque colonne une variable
str(weather)

# Les variables qui commencent par X semblent etre une journee du mois
# La fonction gather() permet de prendre plusieurs colonnes et les condenser

# gather(data, nom de la colonne de la variable, nom de la colonne de valeurs, colonnes a condenser)

library(tidyr)
weather_gat <- gather(weather, Jour, Valeur, X_1:X_31)
head(weather_gat)

# La fonction spread() permet de prendre une colonne et de l'etendre
# gather(data, colonnes a etendre, valeur a transposer)
weather_tidy <- spread(weather_gat, Mesure, Valeur)
tail(weather_tidy)

# La colonne Periode contient deux informations: un mois et une annee
# La fonction separate() permet de separer les elements d'une meme colonne

# separate(data, colonne de valeur a separer, nouveau noms des colonnes, type de separateur)

weather_tidy_date <- separate(weather_tidy, Periode, c("Mois", "Annee"), sep = "/")
head(weather_tidy_date, n = 10)

# La fonction unite() pourrait etre utiliser pour renverser separate()

# Modifier la variable Jour pour retirer le "X_" au debut de chaque numero de jour
weather_tidy_date$Jour <- sub("X_", "", weather_tidy_date$Jour)
tail(weather_tidy_date)

# Reordonner les donnees selon le jour
weather_tidy_date$Jour <- as.numeric(weather_tidy_date$Jour)
weather_very_tidy <- weather_tidy_date %>%
arrange(Jour)

head(weather_very_tidy, n = 10)

### Preparation des donnees pour l'analyse
# Transformer dans le bon type de donnees
weather_very_tidy$Max_Speed_Wind <- as.numeric(weather_very_tidy$Max_Speed_Wind)
weather_very_tidy$Max_Temp <- as.numeric(weather_very_tidy$Max_Temp)
weather_very_tidy$Min_Temp <- as.numeric(weather_very_tidy$Min_Temp)
weather_very_tidy$Mean_Temp <- as.numeric(weather_very_tidy$Mean_Temp)
weather_very_tidy$Total_Precip <- as.numeric(weather_very_tidy$Total_Precip)

# Revoir les donnees
str(weather_very_tidy)
summary(weather_very_tidy)

# Retirer la variable Max_Speed_Wind parce qu'elle contient trop de NA
weather_clean <- weather_very_tidy %>%
select(-Max_Speed_Wind)

# Est-ce quèil reste des valeurs manquantes
any(is.na(weather_clean))

# Trouver les valeurs manquantes
weather_manquant <- weather_clean[rowSums(is.na(weather_clean)) > 0,]
weather_manquant

# Investiguer la raison 
# Retirer les valeurs manquantes
# La fonction complete.cases() permet de retirer toutes les lignes ou une observation est manquante.
weather_very_clean <- weather_clean[complete.cases(weather_clean), ]

# Revoir les donnees pour des valeurs extremes ou aberrantes
# Valeur aberrante
summary(weather_very_clean)

# Trouver la ligne avec des precipitations negatives
ind <- which(weather_very_clean$Total_Precip < 0)

# Voir les donnees pour cette journee
weather_very_clean[ind, ]

# Changer la valeur negative pour 0
weather_very_clean$Total_Precip[ind] <- 0


# Valeur extreme
plot(weather_very_clean$Jour, weather_very_clean$Max_Temp, type = "p", pch = 19)

# Trouver la ligne avec une temperature extreme
ind2 <- which(weather_very_clean$Max_Temp > 50)

# Voir les donnees pour cette journee
weather_very_clean[ind2, ]

# ind2 revenoit un chiffre
ind2

# Voir les donnees deux jours avant et apres cette journee
weather_very_clean[(ind2-2):(ind2+2), ]

# Changer la valeur negative pour 6.7
weather_very_clean$Max_Temp[ind] <- 6.7

# Et c'est fini!
weather_very_clean
