# Manual step: Create Data and Data > CSVs directories and add authors and institutes csvs
library(ready4)
library(ready4show)
library(bookdown)
library(rticles)
X <- Ready4showSynopsis(#background_1L_chr = "Our study is entirely fictional.",
                        coi_1L_chr = "None declared.",
                        #conclusion_1L_chr = "We have identified criteria that can be used to systematically assess extent to which the computational implementation of health economic models adheres to the ethical goals of transparency, reusability and updatability. We have developed an open-source software framework that can support the ethical computational implementation of economic models in youth mental health. Our framework can be used as a prototype for developing future software frameworks to support ethical implementation of CHEMs.",
                        digits_int = 3L,
                        ethics_1L_chr = "None.",
                        funding_1L_chr = "Funded by an Australian Government Research Training Program (RTP) Scholarship to Matthew Hamilton. ",
                        #interval_chr = "three months",
                        keywords_chr = c("computational models", "ethics of modelling", "health economics", "open-source models"),
                        outp_formats_chr = "PDF",
                        #sample_desc_1L_chr = "The study sample is fake data that pretends to be young people aged 12 to 25 years who attended Australian primary care services for mental health related needs between November 2019 to August 2020.",
                        title_1L_chr = "Ethical considerations when planning, implementing and releasing health economic model software - a new proposal")
X <- renewSlot(X,
               "authors_r3", 
               {
                 read.csv("Data/CSVs/Authors.csv") %>% 
                     tibble::as_tibble() %>%
                     ready4show_authors()
               }
               ) 
X <- renewSlot(X,
               "institutes_r3",
               {
                 read.csv("Data/CSVs/Institutes.csv") %>%
                     tibble::as_tibble() %>%
                     ready4show_institutes()

               }) 
X <- renewSlot(X,
               "a_Ready4showPaths@outp_data_dir_1L_chr",
               new_val_xx = ".") 
X <- renewSlot(X,
               "abstract_args_ls",
               {
                 args_ls <- X@abstract_args_ls
                 args_ls$abstract_ls <- list(Summary = "Most health economic analyses are undertaken with the aid of computers. However, the research ethics of implementing health economic models as software (or computational health economic models (CHEMs)) are poorly understood. 
                                                        We propose that developers and funders of CHEMs should adhere to research ethics principles and pursue the goals of: (i) socially acceptable user requirements and design specifications; (ii) fit for purpose implementations; and (iii) socially beneficial post-release use. 
                                                        We further propose that a transparent (T), reusable (R) and updatable (U) CHEM is suggestive of a project team that has largely met these goals.
                                                        We propose six criteria for assessing TRU CHEMs: (T1) software files are publicly available; (T2) developer contributions and judgments on appropriate use are easily identified; 
                                                        (R1) programming practices promote subcomponent reuse; (R2) licenses permit reuse and derivative works; (U1) maintenance infrastructure is in place; and 
                                                        (U2) releases are systematically retested and deprecated.
                                                        Few existing CHEMs would meet all TRU criteria. Addressing these limitations will require the development of new and updated good practice guidelines and investments by governments and other research funders in enabling infrastructure and human capital."
                                             # ,
                                             # Objectives = "We aimed to develop a conceptual and technical framework for implementing open-source mental health systems models and illustrate how it can be applicatied to economic topics in youth mental health.",
                                             # Methods = "We created a software development kit in R to support standardised implementation of mental health systems models. As a worked example, we applied the toolkit to develop open-source youth mental health utility mapping models, which we assessed against five principles using 17 standards.",
                                             # Results = "Six R packages and a coding style dataset provide a toolkit for implementing mental health models that are TIMELY - Transparent, Iterative, Modular, Epitomising, Licensed and Yielding. The utility mapping models we developed with this toolkit fully met X and partially met Y TIMELY standards.", 
                                            #Conclusion = "",
                                            # Code = "Visit https://www.ready4-dev.com for more information about how to find, install and apply the prototype software framework and CHEMs developed with it."
                                            )
                 args_ls
                 }
               )
X@tables_in_body_lgl <- T
X@figures_in_body_lgl <- T
#X@rmd_fl_nms_ls$PDF <- "TEST"#"Parent_PDF"
# authorData(X) # Update ready4show so that default is to not overwrite Child_RMDs / only overwrite header and abstract
# Pause for interactivity
# Make manual edits of Markdown files
#authorReport(X, consent_1L_chr = "Y") # For Preprint
params_ls <- list(X = X)
#params_ls$X@figures_in_body_lgl <- params_ls$X@tables_in_body_lgl <- F
rmarkdown::render(paste0("Markdown/Manuscript/Parent_",
                         "PDF",#
                         "/",
                         "Springer",#
                         ".Rmd"),
                  output_format = NULL,
                  params = params_ls,
                  output_file = "Submission.pdf",
                  output_dir = "Reports/Manuscript")
## For Tex Export - Copy Tex and image files into new folder and then remove all "../Data/images/" parts of paths
##
##
Y <- X
Y@outp_formats_chr <- "Word"
Y@tables_in_body_lgl <- Y@figures_in_body_lgl <- F
authorReport(Y, consent_1L_chr = "Y")
# Pause for interactivity
# 4554 Wordcount
