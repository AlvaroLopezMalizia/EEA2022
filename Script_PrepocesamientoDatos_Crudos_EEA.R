

#PREPROCESAMIENTO DATOS CRUDOS
#TP FINAL EEA2022 ELIANA INES PADULA/ALVARO LOPEZ MALIZIA
#Cargo libreria para R-studio/Json
#CARGO LIBRERIA

library(dplyr)
library(purrr)
library(ggplot2)



#Cargo todas las tablas
clinical <- read.delim("C:/Users/alope/OneDrive/Escritorio/Datos_Nuevos_TP2022/DATOS/clinical.tsv")
exposure <- read.delim("C:/Users/alope/OneDrive/Escritorio/Datos_Nuevos_TP2022/DATOS/exposure.tsv")
analyte <- read.delim("C:/Users/alope/OneDrive/Escritorio/Datos_Nuevos_TP2022/DATOS/analyte.tsv")
aliquot <- read.delim("C:/Users/alope/OneDrive/Escritorio/Datos_Nuevos_TP2022/DATOS/aliquot.tsv")
slide <- read.delim("C:/Users/alope/OneDrive/Escritorio/Datos_Nuevos_TP2022/DATOS/slide.tsv")
table <- read.delim("C:/Users/alope/OneDrive/Escritorio/Datos_Nuevos_TP2022/DATOS/table.tsv")
sample <- read.delim("C:/Users/alope/OneDrive/Escritorio/Datos_Nuevos_TP2022/DATOS/sample.tsv")
family_history<- read.delim("C:/Users/alope/OneDrive/Escritorio/Datos_Nuevos_TP2022/DATOS/family_history.tsv")



#Uno las tablas
#SI quiero hacer el JOIN completo
Datos<-exposure %>% inner_join(clinical)
Datos<-Datos %>% inner_join(slide)
Datos<-Datos %>%inner_join(sample) #Lo hace naturamente por case_id


#Agrego información sobre la mutacion de interés
Datos_final<-Datos %>%inner_join(table,by=c("case_submitter_id"="Patient.ID"))




#SACO LAS COLUMNAS QUE NO ME INTERESAN

features<-c("bmi",
            "weight",
            "height",
            "gender",
            "ethnicity",
            "race",
            "primary_diagnosis",
            #"tumor_grade",
            #"tumor_stage",
            "days_to_last_follow_up",
            #"tumor_largest_diameter",
            "year_of_birth",
            "year_of_death",
            "site_of_tissue_or_organ_of_origin",
            #"cigarettes_per_day",
            #"pack_years_smoked",
            "years_smoked",
            "percent_lymphocyte_infiltration",
            "percent_necrosis",
            "percent_neutrophil_infiltration",
            "percent_stromal_cells",
            "percent_tumoral_cells",
            "days_to_birth",
            "days_to_death",
            "Altered"
            ) #"days_to_recurrence",           





Datos_limpio<-Datos_final[,colnames(Datos_final) %in% features]




#SACO LOS '-- y los cambio por NA

Datos_limpio$bmi<-as.numeric(Datos_limpio$bmi)
Datos_limpio$height<-as.numeric(Datos_limpio$height)
Datos_limpio$weight<-as.numeric(Datos_limpio$weight)
Datos_limpio$year_of_birth<-as.numeric(Datos_limpio$year_of_birth)
Datos_limpio$year_of_death<-as.numeric(Datos_limpio$year_of_death)
Datos_limpio$days_to_death<-as.numeric(Datos_limpio$days_to_death)
Datos_limpio$days_to_last_follow_up<-as.numeric(Datos_limpio$days_to_last_follow_up)
Datos_limpio$tumor_largest_diameter<-as.numeric(Datos_limpio$tumor_largest_diameter)
Datos_limpio$year_of_birth<-as.numeric(Datos_limpio$year_of_birth)
Datos_limpio$year_of_death<-as.numeric(Datos_limpio$year_of_death)
Datos_limpio$site_of_tissue_or_organ_of_origin<-as.numeric(Datos_limpio$site_of_tissue_or_organ_of_origin)
Datos_limpio$cigarettes_per_day<-as.numeric(Datos_limpio$cigarettes_per_day)
Datos_limpio$pack_years_smoked<-as.numeric(Datos_limpio$pack_years_smoked)
Datos_limpio$years_smoked<-as.numeric(Datos_limpio$years_smoked)
Datos_limpio$percent_lymphocyte_infiltration<-as.numeric(Datos_limpio$percent_lymphocyte_infiltration)
Datos_limpio$percent_necrosis<-as.numeric(Datos_limpio$percent_necrosis)
Datos_limpio$percent_neutrophil_infiltration<-as.numeric(Datos_limpio$percent_neutrophil_infiltration)
Datos_limpio$percent_neutrophil_infiltration<-as.numeric(Datos_limpio$percent_neutrophil_infiltration)
Datos_limpio$percent_stromal_cells<-as.numeric(Datos_limpio$percent_stromal_cells)
Datos_limpio$percent_tumoral_cellss<-as.numeric(Datos_limpio$percent_tumoral_cells)





#solo datos completos de días para la muerte (Variable Objetivo)
Datos_Completos<-Datos_limpio[complete.cases(Datos_limpio[,"days_to_death"]),] 


#Guardo el archivo en csv

write.csv2(Datos_Completos, "Base_datos_dias_muerte_completo.csv")














