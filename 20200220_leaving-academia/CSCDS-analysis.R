


library(dplyr)
library(ggplot2) 
library(magrittr)
library(forcats)
library(tidyr)
library(knitrBootstrap)
library(RColorBrewer)
library(highcharter)
library(countrycode)
library(ggforce)
library(limma)



# Source: https://www.kaggle.com/c/kaggle-survey-2019/overview

## Analysis of data science myths

# Read in data 
schema = read.csv("data/survey_schema.csv")
questions = read.csv("data/questions_only.csv")
multiple = read.csv("data/multiple_choice_responses.csv")

# select smaller subset of data and rename variables
df = multiple %>% select(Q1, Q2, Q3, Q4, Q5, Q8, starts_with("Q9"), starts_with("Q13"),
                         Q14, Q15, starts_with("Q18"), Q19, starts_with("Q20"), 
                         Q23, starts_with("Q24"), starts_with("Q27"), starts_with("Q31")) %>% 
                  rename(age = Q1, 
                         gender = Q2, 
                         country = Q3, 
                         edu = Q4, 
                         position = Q5, 
                         analysis = Q9_Part_1, 
                         infrastructure = Q9_Part_2, 
                         `Built ML prototype` = Q9_Part_3, 
                         `Build ML models` = Q9_Part_4, 
                         `Improve ML models` = Q9_Part_5, 
                         `Research ML models` = Q9_Part_6, 
                         `N/A ML` = Q9_Part_7, 
                         Udacity = Q13_Part_1, 
                         Coursera = Q13_Part_2, 
                         Edx = Q13_Part_3, 
                         Datacamp = Q13_Part_4, 
                         Dataquest = Q13_Part_5, 
                         Kaggle = Q13_Part_6, 
                         FastAI = Q13_Part_7, 
                         Udemy = Q13_Part_8, 
                         LinkedIn = Q13_Part_9, 
                         University = Q13_Part_10, 
                         `No course` = Q13_Part_11,  
                         `Other course`= Q13_Part_12,
                         primary_tool = Q14, 
                         code_yrs = Q15, 
                         Python = Q18_Part_1, 
                         R = Q18_Part_2, 
                         SQL = Q18_Part_3, 
                         C = Q18_Part_4, 
                         `C++` = Q18_Part_5, 
                         Java = Q18_Part_6, 
                         JavaScript = Q18_Part_7, 
                         TypeScript = Q18_Part_8, 
                         Bash = Q18_Part_9, 
                         Matlab = Q18_Part_10, 
                         yrs_ML = Q23, 
                         lin_logistic = Q24_Part_1,
                         trees = Q24_Part_2, 
                         boosted = Q24_Part_3, 
                         bayes = Q24_Part_4, 
                         evo_nets = Q24_Part_5, 
                         dense_nets = Q24_Part_6, 
                         convo_nets = Q24_Part_7, 
                         gen_nets = Q24_Part_8, 
                         rec_nets = Q24_Part_9, 
                         trans_nets= Q24_Part_10, 
                         None = Q24_Part_11, 
                         nlp_word_embed = Q27_Part_1, 
                         nlp_encode_decode = Q27_Part_2, 
                         nlp_context_embed = Q27_Part_3, 
                         nlp_transform = Q27_Part_4, 
                         nlp_None = Q27_Part_5) 

# Remove first row of variable full names 

df = df[-1,]

# Set color palette (color blind friendly)
cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

# Demographics 


df %>% 
  select(gender, age) %>% 
  droplevels() %>% 
  ggplot(aes(x = age, fill = gender)) + 
  geom_bar(position = "fill") + 
  labs(x = "age categories", 
       y = "Percentage", 
       title = "Gender groups by age categories") +
  scale_y_continuous(expand = c(0,0), limits = c(0, 1)) +
  theme_minimal() +
  scale_fill_manual(values = c("#E69F00", "#0072B2" ,"#D55E00" ,"#009E73"))
                               
                               
# Location of respondents

highchart(type = "map") %>%
  hc_add_series_map(worldgeojson,
                    df %>% 
                      group_by(country) %>% 
                      summarise(total = n()) %>% 
                      ungroup() %>%
                      mutate(iso2 = countrycode(country, origin="country.name", destination="iso2c")),
                    value = "total", joinBy = "iso2") %>%
  hc_title(text = "Kagglers by country") %>%
  hc_colorAxis(minColor = "#e8eded", maxColor = "#4c735e")



# Who identifies themselves as doing "data science"

position_factor = 
  forcats::fct_collapse(df$position, 
                        "Business Analyst"= "Business Analyst", 
                        "Data Analyst" = "Data Analyst",
                        "Data Engineer" = "Data Engineer", 
                        "Database Engineer" = "DBA/Database Engineer", 
                        "Not employed" = "Not employed", 
                        "Other" = "Other", 
                        "Project Manager" = "Product/Project Manager",
                        "Research Scientist" = "Research Scientist",
                        "Software Engineer" = "Software Engineer",
                        "Student" = "Student",
                        Missing = c("", "Select the title most similar to your current role (or most recent title if retired): - Selected Choice") 
  )


data.frame(fct_count(position_factor)) %>% 
  mutate(prop = round(n/sum(n),2)) %>% 
  ggplot(aes(x = reorder(f, -prop), y = prop, fill = f)) + geom_bar(stat = "identity") + 
  theme_minimal() + 
  scale_y_continuous(expand = c(0,0), limits = c(0, 1)) + 
  ggtitle("Type of position") + 
  labs(x = "Position", 
       y = "Percentage") + 
  theme(legend.position = "none") + 
  geom_text(aes(x = f, 
                y = prop + 0.05, label = round(prop, 2))) + coord_flip()


# Myth 1b: You need a PhD to do data science 

new_factor = 
  forcats::fct_collapse(df$edu, 
              "Bachelor's"= "Bachelor’s degree", 
              "Master's" = "Master’s degree",
              PhD = "Doctoral degree", 
              Highschool = "No formal education past high school", 
              "Professional degree" = "Professional degree", 
              "Some college/uni" = "Some college/university study without earning a bachelor’s degree",
              Missing = c("", "I prefer not to answer", "What is the highest level of formal education that you have attained or plan to attain within the next 2 years?") 
               )


phdtxt = "Only 14% of self-identified data scientists hold a PhD!"

data.frame(fct_count(new_factor)) %>% 
  mutate(prop = round(n/sum(n),2), 
         adv = ifelse(f == "PhD", TRUE, FALSE)) %>% 
  ggplot(aes(x = reorder(f, -prop), y = prop, fill = adv)) + geom_bar(stat = "identity") + 
  theme_minimal() + 
  geom_label(data = data.frame(x = 1.5, y = .5, label = phdtxt), 
             aes(x = x, y = y, label = phdtxt), 
             hjust = 0, 
             lineheight = 8, 
             inherit.aes = FALSE,  
             label.size = NA) +
  geom_curve(data = data.frame(x = 3, y = .45, xend = 3, yend = .25), 
             mapping = aes(x = x, y = y, xend = xend, yend = yend), 
             colour = "orange", 
             size = 0.75, 
             curvature = -0.1, 
             arrow = arrow(length = unit(0.01, "npc"), type = "closed"),
             inherit.aes = FALSE) +
  scale_y_continuous(expand = c(0,0), limits = c(0, 1)) + 
  ggtitle("Highest level of education, n = 19717") + 
  labs(x = "Highest level of education", 
       y = "Percentage", 
       caption = "Data source: https://www.kaggle.com/c/kaggle-survey-2019/overview") + 
  theme(legend.position = "none") + 
  geom_text(aes(x = f, 
                y = prop + 0.05, label = round(prop, 2)))
  
# Q1b You need a Data Science degree to learn how to do data science ###

df %>% 
  filter(code_yrs != "I have never written code") %>% 
  select(Udacity:`Other course`) %>% 
  droplevels() %>% 
  mutate_all(funs(na_if(., ""))) %>% 
  summarise_all(funs(sum(!is.na(.)))) %>% 
  summarise_all(~ .x / nrow(df))  %>% 
  gather(language, prop) %>% 
  ggplot(aes(x = reorder(language, -prop), y = prop, fill = language)) + 
  geom_bar(stat = "identity") + 
  scale_y_continuous(expand = c(0,0), limits = c(0,1)) + 
  geom_text(aes(label = round(prop,2)), vjust = -0.5, position = position_dodge(0.9)) + 
  ggtitle("On which platforms have you begun or completed data science courses?", 
          subtitle = "Multiple choice categories") + 
  labs(x = "",
       y = "percentage",
       caption = "Data source: https://www.kaggle.com/c/kaggle-survey-2019/overview") + 
  theme_minimal() + 
  theme(legend.position = "none")

# Most people haven't been coding that long 

coding_factor = 
  forcats::fct_collapse(df$code_yrs, 
                        "< 1 year"= "< 1 years", 
                        "1-2 years" = "1-2 years",
                        "3-5 years" = "3-5 years", 
                        "5-10 years" = "5-10 years", 
                        "10-20 years" = "10-20 years", 
                        "20+ years" = "20+ years",
                        Missing = c("", "How long have you been writing code to analyze data (at work or at school)?") 
  )


coding_text = "Most people have been coding for only1-2 years!"

data.frame(fct_count(coding_factor)) %>% 
  mutate(prop = round(n/sum(n),2), 
         adv = ifelse(f == "1-2 years", TRUE, FALSE), 
         f = factor(f, levels = c("< 1 year", "1-2 years", "3-5 years", "5-10 years", "10-20 years", "20+ years"))) %>%
  filter(f != "Missing" & f != "I have never written code") %>% 
  ggplot(aes(x = f, y = prop, fill = adv)) + geom_bar(stat = "identity") + 
  scale_y_continuous(expand = c(0,0), limits = c(0, 1)) + 
  ggtitle("Number of years coding, n = 19717") + 
  labs(x = "Number of years", 
       y = "Percentage", 
       caption = "Data source: https://www.kaggle.com/c/kaggle-survey-2019/overview") + 
  theme(legend.position = "none") + 
  theme_minimal() + 
  geom_text(aes(x = f, 
                y = prop + 0.05, label = round(prop, 2))) +
  geom_curve(data = data.frame(x = 3, y = .60, xend = 2, yend = .35), 
             mapping = aes(x = x, y = y, xend = xend, yend = yend), 
             colour = "orange", 
             size = 0.75, 
             curvature = 0.1, 
             arrow = arrow(length = unit(0.01, "npc"), type = "closed"),
             inherit.aes = FALSE) + 
  geom_label(data = data.frame(x = 2, y = .65, label = coding_text), 
             aes(x = x, y = y, label = coding_text), 
             hjust = 0, 
             lineheight = 8, 
             inherit.aes = FALSE,  
             label.size = NA)


# Q3 Learning Python will be enough


# Tools people used 

box = "Basic statistical software: Excel, Google sheets \n
Development environments: RStudio, JupyterLab \n
Other: 
Statistical software: Python, R, SPSS, SAS \n
Business intelligence: Salesforce, Tableau, Spotfire \n
Cloud based: AWS, Azure \n"

df %>% filter(code_yrs == "I have never written code") %>% 
  mutate(tool = fct_recode(primary_tool, 
                           "Statistical software" = "Advanced statistical software (SPSS, SAS, etc.)",
                           "Basic software" = "Basic statistical software (Microsoft Excel, Google Sheets, etc.)",
                           "BI software" = "Business intelligence software (Salesforce, Tableau, Spotfire, etc.)", 
                           Cloud = "Cloud-based data software & APIs (AWS, GCP, Azure, etc.)",
                           "Dev. environment" = "Local development environments (RStudio, JupyterLab, etc.)", 
                           Other = "Other",
                           Missing = "", 
                           Missing = "What is the primary tool that you use at work or school to analyze data? (Include text response) - Selected Choice")) %>% 
  count(tool) %>% 
  mutate(prop = round(n/sum(n),2))  %>% 
  ggplot(aes(x = reorder(tool, -prop), y = prop, fill = tool)) + geom_bar(stat = "identity") + 
  theme_minimal() + 
  geom_label(data = data.frame(x = 2, y = .75, label = box), 
             aes(x = x, y = y, label = label), 
             hjust  = 0, 
             lineheight = .7, 
             inherit.aes = FALSE, 
             label.size = .2) + 
  geom_text(aes(label = round(prop,2)), vjust = -0.5, position = position_dodge(0.9)) + 
  scale_y_continuous(expand = c(0,0), limits = c(0, 1)) + 
  ggtitle("Primary tool used at work or school", 
          subtitle = "Multiple choice categories") + 
  labs(x = "Tool", 
       y = "Percentage", 
       caption = "Data ource: https://www.kaggle.com/c/kaggle-survey-2019/overview") + 
  theme(legend.position = "none")


# Programming languages people use 

 df %>% 
  filter(code_yrs != "I have never written code") %>% 
  select(Python:Matlab) %>% 
  droplevels() %>% 
  mutate_all(funs(na_if(., ""))) %>% 
  summarise_all(funs(sum(!is.na(.)))) %>% 
  summarise_all(~ .x / nrow(df))  %>% 
  gather(language, proportion) %>% 
  ggplot(aes(x = reorder(language, -proportion), y = proportion, fill = language)) + 
  geom_bar(stat = "identity") + 
  scale_y_continuous(expand = c(0,0), limits = c(0,1)) + 
  geom_text(aes(label = round(proportion,2)), hjust = -1, position = position_dodge(1.1)) + 
  ggtitle("Programming language used on a daily basis") + 
  labs(x = "Programming language", 
       caption = "Data source: https://www.kaggle.com/c/kaggle-survey-2019/overview") + 
  theme_minimal() + 
  theme(legend.position = "none") + 
  coord_flip()
 
 
# Myth 4. Data Science == Machine learning and AI
 
 df %>% filter(!position %in% c("Student", "Not employed")) %>% 
  mutate(ml_atwork = fct_recode(Q8, 
                                "No" = "No (we do not use ML methods)",
                                "Not yet, but eventually" = "We are exploring ML methods (and may one day put a model into production)",
                                "Yes, less than 2 years" = "We recently started using ML methods (i.e., models in production for less than 2 years)",
                                "Yes, more than 2 years" = "We have well established ML methods (i.e., models in production for more than 2 years)",
                                "Yes, but not in production"= "We use ML methods for generating insights (but do not put working models into production)",
                                "Missing" = "", 
                                NULL = "Does your current employer incorporate machine learning methods into their business?)", 
                                "Do not know" = "I do not know")) %>% 
  count(ml_atwork) %>% 
  mutate(prop = round(n/sum(n),2), 
         ml = ifelse(ml_atwork %in% c("Yes, less than 2 years", "Yes, more than 2 years", "Yes, but not in production"), "Yes", "No")) %>% 
  ggplot(aes(x = ml_atwork, y = prop, fill = ml)) + geom_bar(stat = "identity") + 
  theme_minimal() + 
  geom_text(aes(label = round(prop,2)), vjust = -0.5, position = position_dodge(0.9)) + 
  scale_y_continuous(expand = c(0,0), limits = c(0, 1)) + 
  ggtitle("Is machine learning used in your organization?") + 
  labs(x = "", 
       y = "Percentage", 
       caption = "Data source: https://www.kaggle.com/c/kaggle-survey-2019/overview") + 
  theme(legend.position = "none")

# Between country variability
 
highchart(type = "map") %>%
   hc_add_series_map(worldgeojson,
                     df %>% filter(!position %in% c("Student", "Not employed")) %>% 
                       select(country, Q8) %>% 
                       mutate(ml_atwork = fct_recode(Q8, 
                                                     "No" = "No (we do not use ML methods)",
                                                     "No"= "We are exploring ML methods (and may one day put a model into production)",
                                                     "Yes" = "We recently started using ML methods (i.e., models in production for less than 2 years)",
                                                     "Yes" = "We have well established ML methods (i.e., models in production for more than 2 years)",
                                                     "Yes"= "We use ML methods for generating insights (but do not put working models into production)",
                                                     "Missing" = "", 
                                                     NULL = "Does your current employer incorporate machine learning methods into their business?)", 
                                                     "Do not know" = "I do not know")) %>%
                       droplevels() %>% 
                       group_by(country) %>% 
                       count(ml_atwork) %>% 
                       mutate(prop = round(n/sum(n),2)) %>% 
                       filter(ml_atwork == "Yes") %>% 
                       select(country, n, prop) %>% 
                       ungroup() %>% 
                       mutate(iso2 = countrycode(country, origin="country.name", destination="iso2c")),
                     value = "prop", joinBy = "iso2") %>%
   hc_title(text = "Machine learning users by country") %>%
   hc_colorAxis(minColor = "#e8eded", maxColor = "#4c735e")
   
   


# As I data scientist, most of the job is building models  

df %>% filter(!position %in% c("Student", "Not employed") 
              & !Q8 %in% c("I do not know", "No (we do not use ML methods)")) %>% 
  select(analysis:`Research ML models`) %>% 
  droplevels() %>% 
  mutate_all(funs(na_if(., ""))) %>% 
  summarise_all(funs(sum(!is.na(.)))) %>% 
  summarise_all(~ .x / nrow(df))  %>% 
  gather(task, proportion) %>% 
  ggplot(aes(x = reorder(task, -proportion), y = proportion, fill = task)) + 
  geom_bar(stat = "identity") + 
  scale_y_continuous(expand = c(0,0), limits = c(0,1)) + 
  geom_text(aes(label = round(proportion,2)), vjust = -0.5, position = position_dodge(0.9)) + 
  ggtitle("Machine learning related tasks") + 
  labs(x = "Task", 
       caption = "Data source: https://www.kaggle.com/c/kaggle-survey-2019/overview") + 
  theme_minimal() + 
  theme(legend.position = "none")
  
 
 #The old addage "80% of data analysis is cleaning data"
 
 
# Venn diagram 

venn_ds = data.frame(x = c(0, 0.866, -0.866),
                     y = c(1, -0.5, -0.5),
                     labels = c('Math & Stat', 'Domain Knowledge', 'Programming')) 

ggplot(data = venn_ds, aes(x0 = x, y0 = y, r = 1.5, fill = labels)) +
  geom_circle(alpha = .3, size = 1, colour = 'grey') +
  coord_fixed() +
  theme_void() + 
  theme(legend.position = 'bottom') +
  scale_fill_manual(values = c('cornflowerblue', 'firebrick',  'gold')) +
  scale_colour_manual(values = c('cornflowerblue', 'firebrick', 'gold'), guide = FALSE) +
  labs(fill = NULL) +
  theme(legend.position = "none") + 
  annotate("text", x = venn_ds$x, y = venn_ds$y, label = venn_ds$labels, size = 5)


## Venn diagram to skills 
# x & y = Position  of text and text
Academia = c(1, 0, 1)
DS = c(0, 1, 1)
x = c(1.2, -1.2, 0)
y = c(-0.6, -0.6, -0.6)
skill = c("GPA, Poster presentation\n Published papers\n Teaching \n Teaching/research assistant", 
          "Portfolio\n Work experience \nTechnical skills \nTeam management \nBusiness accumen", 
          "Critical thinking \ncommunication \ndomain knowledge \nproblem solving \nintellectual curiosity")

venn_ds1 = data.frame(Academia, DS, x, y, skill)
venn_ds1

# define circle parameters
df.venn2 = data.frame(x = c(-0.866, 0.866), 
                      y = c(-0.5, -0.5), 
                      labels = c("Data Science", "Academia"))

df.venn2
ggplot(df.venn2) +
  geom_circle(aes(x0 = x, y0 = y, r = 1.5, fill = labels), alpha = .3, size = 1, colour = 'grey') +
  coord_fixed() +
  theme_void() +
  theme(legend.position = 'bottom') +
  scale_fill_manual(values = c('cornflowerblue', 'firebrick',  'gold')) +
  scale_colour_manual(values = c('cornflowerblue', 'firebrick', 'gold'), guide = FALSE) +
  labs(fill = NULL) +
  annotate("text", x = df$x, y = df$y, label = df$skill, size = 5)



# 2018 survey - Q5 major 

test= read.csv("data/multiple_choice_responses2018.csv")

names(test)

table(multiple_2018$Q5)

major_factor = 
  forcats::fct_collapse(multiple_2018$Q5, 
                        "Business"= "A business discipline (accounting, economics, finance, etc.)", 
                        "Comp. Science" = "Computer science (software engineering, etc.)",
                        Eng = "Engineering (non-computer focused)", 
                        "Environment/Geo" = "Environmental science or geology", 
                        "Fine arts" = "Fine arts or performing arts", 
                        "No major" = "I never declared a major",
                        "IT" = "Information technology, networking, or system administration",
                        "Math/Stats" = "Mathematics or statistics",
                        "Life Science" = "Medical or life sciences (biology, chemistry, medicine, etc.)",
                        "Other" = "Other",
                        "Physics/astronomy" = "Physics or astronomy",
                        "Humanities" = "Humanities (history, literature, philosophy, etc.)",
                        "Social Science" = "Social sciences (anthropology, psychology, sociology, etc.)",
                        Missing = c("Which best describes your undergraduate major? - Selected Choice"), 
                        NULL = "")

data.frame(fct_count(major_factor)) %>% 
  droplevels() %>% 
  mutate(prop = round(n/sum(n),2)) %>% 
  ggplot(aes(x = reorder(f, -prop), y = prop, fill = f)) + geom_bar(stat = "identity") + 
  theme_minimal() + 
  scale_y_continuous(expand = c(0,0), limits = c(0, 1)) + 
  ggtitle("Major in University") + 
  labs(x = "Position", 
       y = "Percentage") + 
  theme(legend.position = "none") + 
  geom_text(aes(x = f, 
                y = prop + 0.05, label = round(prop, 2))) + coord_flip() + 
  scale_fill_viridis(option = "D", discrete = TRUE)
  
  
