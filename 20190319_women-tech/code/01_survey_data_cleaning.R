
#### Install packages ####
pacman::p_load(dplyr, magrittr, purrr, stringr, summarytools, forcats)

# "https://www.kaggle.com/juliasilge/stack-overflow-feeling-of-belonging?utm_medium=partner&utm_source=stackoverflow&utm_campaign=developer+survey+2018"
# source: https://insights.stackoverflow.com/survey
# Gender question appears in 2014 onwards

#### Read in data ####
folder = "data/"
files = list.files(path = folder, pattern="\\.csv$")
df_list = map(paste(folder, files, sep = ""), read.csv)
names(df_list) = str_remove(files, "\\.csv$")
list2env(df_list ,.GlobalEnv)


# Todo

# Make categorical variables consistent across survey years (check occupation, industry, yrs_exp)
# Turn categorical programming languages into dummy variables
# Identify main variables of interest: women in different occupations, levels of experience, education, salaries



# Let'start cleaning!


#### 2015 ####
# For some reason, the 2015 survey's column names appear in the first row and the column names are the instructions
colnames(survey_2015) = as.character(unlist(survey_2015[1,]))
df_2015 = survey_2015

# then remove that first row

df_2015= df_2015[-1,]

# The column names are actually much better now, but there are some upper cases that I'd like to get rid of 

df_2015  = survey_2015 %>% 
        rename_all(tolower) %>% 
        filter(country != "country") %>% 
        select(country, age, gender, 
                     yrs_exp = `years it / programming experience`, 
                     occupation, industry,
                     C = `current lang & tech: c`, 
                     c_plus = `current lang & tech: c++`, 
                     c_sharp = `current lang & tech: c#`, 
                     java = `current lang & tech: java`, 
                     java_script = `current lang & tech: javascript`, 
                     node_js = `current lang & tech: node.js`, 
                     obj_c = `current lang & tech: objective-c`, 
                     php = `current lang & tech: php`, 
                     python = `current lang & tech: python`, 
                     R = `current lang & tech: r`, 
                     ruby = `current lang & tech: ruby`, 
                     sql = `current lang & tech: sql`, 
                     no_training = `training & education: no formal training`, 
                     job_training = `training & education: on the job`, 
                     bcamp_training = `training & education: boot camp or night school`, 
                     online_training = `training & education: online class`, 
                     mentor_training = `training & education: mentorship`, 
                     cert_training = `training & education: industry certification`, 
                     college_training = `training & education: some college, but no cs degree`, 
                     bs_training = `training & education: bs in cs`, 
                     masters_training = `training & education: masters in cs`, 
                     phd_training = `training & education: phd in cs`, 
                     comp = compensation, 
                     satisfaction = `job satisfaction`)


# Recode factors 

dfSummary(df_2015) 

df_2015  %<>% mutate(gender = factor(ifelse(gender == "Female", "Female", 
                                     ifelse(gender == "Male", "Male", 
                                            ifelse(gender == "Other", "Non-binary",
                                                   ifelse(gender == "", NA, NA))))))

levels(df_2015$age)[levels(df_2015$age)=="Age"] = NA
levels(df_2015$age)[levels(df_2015$age)=="Prefer not to disclose"] = NA

df_2015  %<>% mutate(age = fct_relevel(age, "< 20", "20-24", "25-29", "30-34", "35-39", "40-50", "51-60", "> 60"))

##this didn't work 
df_2015  %<>% mutate_at(vars(yrs_exp:occupation), funs(recode(., "" = NA_real_)))

#### 2016 #####
# things that will need recoding: tech_do, education
df_2016 = survey_2016 %>% 
        select(country, gender, 
               age = age_range, 
               occupation, occupation_group, yrs_exp = experience_range, 
               comp = salary_range, tech_do, industry, women_on_team, satisfaction = job_satisfaction,
               education)



#### 2017 #####
# first row isn't messed up
# no question about job industry
# I took years of coding as "experience" (like other survey years) rather than coding for a living
df_2017 = survey_2017 %>% 
        rename_all(tolower) %>% 
        select(country, training = formaleducation, undergrad = majorundergrad, 
               status = employmentstatus, yrs_exp = yearsprogram, contains("developer"), 
               gender, race, comp = salary)


#### 2018 ####
df_2018 = survey_2018 %>% 
        rename_all(tolower) %>% 
        select(country, student, education = formaleducation, undergrad = undergradmajor, 
               devtype, yrs_exp = yearscoding, satisfaction = jobsatisfaction, comp = convertedsalary, 
               languageworkedwith, gender, age)

## Data harmonization still incomplete

saveRDS(df_2018, file = 'data/so_survey_2018.rds')
saveRDS(df_2017, file = 'data/so_survey_2017.rds')
saveRDS(df_2016, file = 'data/so_survey_2016.rds')
saveRDS(df_2015, file = 'data/so_survey_2015.rds')


