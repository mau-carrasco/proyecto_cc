# Load packages
library(tidyverse)
library(shiny)
library(shinythemes)
library(readxl)

# Prepare data
constituyentes <- readRDS("constituyentes.rds")

constituyentes <- constituyentes %>% mutate(fecha = as.Date(constituyentes$fecha), voto = factor(voto, levels = c("A favor", "Abstención", "En contra")))

# Define UI
shinyUI(navbarPage(
               title = strong("LaConstituyente.CL"),
               tags$script(HTML(
               "var header = $('.navbar > .container-fluid');
               header.append('<div style=\"float:right\"><a href=\"https://github.com/mau-carrasco/proyecto_cc\"><img src=\"https://cdn-icons-png.flaticon.com/512/25/25231.png\" alt=\"alt\" style=\"float:right;width:33px;height:41px;padding-top:10px;\"> </a></div>');
               console.log(header)")
               ),
               theme = shinytheme("simplex"),
               tabPanel("Novedades",
                        h4(strong("Bienvenidos y bienvenidas a LaConstituyente.CL")),
                        fluidRow(column(12,
                                        p("En este sitio web podrás visualizar y analizar los resultados de las votaciones celebradas en el pleno de la Convención Constituional de Chile."),
                                        p("Cada semana, nuestro equipo realiza un análisis de contigencia sobre los principales hechos ocurridos al interior de la Convención Constitucional, para informar adecuada y prontamente a los usuarios de la plataforma acerca de los avances en materia de redacción y sanción de normas constitucionales."),
                                        p("Para conocer en detalle lo ocurrido al interior de la Convención Constitucional durante la última semana, puedes ingresar gratuitamente a la bitácora del convencional constituyente, Fernando Atria."),
                                        p("Esta semana, Fernando Atria analiza las normas que fueron aprobadas por el pleno de la CC durante la semana pasada y que formarán parte del borrador de la propuesta constitucional que será sometida a plebiscito en septiebre de este año.")
                        )),
                        fluidRow(column(12,
                                        align = "center",
                                        HTML('<iframe width="90%" height = "500" src="https://www.youtube.com/embed/r1myfY9K4iY" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>')
                        )),
                        br(),
                        br(),
                        fluidRow(
                          column(4,
                                 p(align = "center",
                                   a(img(src = "logo_casa_comun.png", height = 50, width = 100), href = "https://www.lacasacomun.cl/"))
                                 ),
                          column(4,
                                 p(align = "center",
                                   a(img(src= "http://www.academia.cl/2021/admision/logo-uahc-hor.svg", height = 60, width = 175), href = "http://www.academia.cl/"))
                                 ),
                          column(4,
                                 p(align = "center",
                                   a(img(src = "https://cl.boell.org/sites/default/files/2019-10/logo-boell-cl-en-city.svg", height = 60, width = 175), href = "https://cl.boell.org/es"))
                          )
                        )
               ),
               tabPanel("Votaciones",
                        h4(strong("Votaciones celebradas en el pleno de la CC")),
                        sidebarPanel(align="center",
                                     selectInput("fecha",
                                                 "Fecha",
                                                 choice = unique(constituyentes$fecha),
                                                 selected = "2022-04-26"),
                                     selectInput("tema",
                                                 "Tema de votación",
                                                 unique(constituyentes$tema),
                                                 selected = NULL),
                                     p("Contenido"),
                                     textOutput("detalle"),
                                     br(),
                                     selectInput("grupo",
                                                 "Grupo de contraste",
                                                 choices = list("Region" = "region",
                                                                "Distrito" = "distrito",
                                                                "Lista" = "lista",
                                                                "Partido" = "partido",
                                                                "Bloque político interno" = "bloque"))
                                     ),
                        mainPanel(align="center",
                                  tabsetPanel(type = "tabs",
                                              tabPanel("Tablas",
                                                       fluidRow(
                                                         column(6,
                                                                p(strong("Resultado general")),
                                                                tableOutput("tabla1")
                                                         ),
                                                         column(6, align="center",
                                                                p(strong("Resultado por grupo de contraste")),
                                                                htmlOutput("tabla2")
                                                         )
                                                       )
                                                       ),
                                              tabPanel("Gráficos",
                                                       fluidRow(
                                                         column(6,
                                                                p(strong("Resultado general")),
                                                                plotOutput("plot1")
                                                         ),
                                                         column(6, align="center",
                                                                p(strong("Resultado por grupo de contraste")),
                                                                plotOutput("plot2")
                                                         )
                                                       )
                                                       ),
                                              tabPanel("Detalle",
                                                       tableOutput("micro"))
                                              ),
                                  fluidRow(
                                    column(4,
                                           p(align = "center",
                                             a(img(src = "logo_casa_comun.png", height = 50, width = 100), href = "https://www.lacasacomun.cl/"))
                                    ),
                                    column(4,
                                           p(align = "center",
                                             a(img(src= "http://www.academia.cl/2021/admision/logo-uahc-hor.svg", height = 60, width = 175), href = "http://www.academia.cl/"))
                                    ),
                                    column(4,
                                           p(align = "center",
                                             a(img(src = "https://cl.boell.org/sites/default/files/2019-10/logo-boell-cl-en-city.svg", height = 60, width = 175), href = "https://cl.boell.org/es"))
                                    )
                                  )
                                  )
                        ),
               tabPanel("Análisis",
                        h4(strong("Análisis de contingencia")),
                        fluidRow(column(12,
                                        p("Desde", strong("laconstituyente.cl"), "nos hemos puesto el objetivo de analizar periodicamente las discusiones y votaciones más relevantes de la Convención Constitucional, tanto a nivel general como en particular, desagregando a los constituyentes en sus respectivos pactos políticos, regiones y distritos."),
                                        p("El análisis periódico de las discusiones y votaciones es realizado por un equipo de investigadores de la", strong("Fundación La Casa Común"), "y la", strong("Universidad Academia de Humanismo Cristiano,"), "que elaboran un reporte mensual, quincenal o semanal, dependiendo de la actividad de la Convención Constitucional.")
                        )),
                        fluidRow(
                          column(6,
                                 h4(strong("Informes")),
                                 p(
                                   "Informe de ",
                                   a("las votaciones realizas en la Convención Constitucional de Chile durante sus primeros tres meses de funcionamiento", 
                                     href = "https://quirky-bohr-1ffc7c.netlify.app/")),
                                 p("Primer informe del ",
                                   a("seguimiento a la comisión sobre Sistema Político, Gobierno, Poder Legislativo y Sistema Electoral", 
                                     href = "https://distracted-hermann-d089fe.netlify.app/")),
                                 p("Segundo informe del seguimiento a la comisión sobre Sistema Político, Gobierno, Poder Legislativo y Sistema Electoral: ",
                                   a("HTML", 
                                     href = "https://practical-bell-c5eb56.netlify.app/"), "|",
                                   a("PDF", 
                                     href = "http://dx.doi.org/10.13140/RG.2.2.12536.16642")),
                                 p("Tercer informe del seguimiento a la comisión sobre Sistema Político, Gobierno, Poder Legislativo y Sistema Electoral: ",
                                   a("HTML", 
                                     href = "https://mystifying-wiles-3644b4.netlify.app/"), "|",
                                   a("PDF", 
                                     href = "http://dx.doi.org/10.13140/RG.2.2.12536.16642")),
                                 p("Primer informe del seguimiento a la comisión sobre Medio Ambiente, Derechos de la Naturaleza, Bienes Naturales Comunes y Modelo Económico: ",
                                   a("HTML", 
                                     href = "https://cocky-austin-f66b2e.netlify.app/"), "|",
                                   a("PDF", 
                                     href = "https://www.researchgate.net/project/LaConstituyentecl")),
                                 p("Segundo informe del seguimiento a la comisión sobre Medio Ambiente, Derechos de la Naturaleza, Bienes Naturales Comunes y Modelo Económico: ",
                                   a("HTML", 
                                     href = "https://compassionate-leakey-52f8e0.netlify.app/"), "|",
                                   a("PDF", 
                                     href = "https://www.researchgate.net/publication/357776009_Segundo_informe_del_seguimiento_a_la_comision_sobre_Medio_Ambiente_Derechos_de_la_Naturaleza_Bienes_Naturales_Comunes_y_Modelo_Economico_semana_del_24_al_30_de_Nov_2021")),
                                 p("Tercer informe del seguimiento a la comisión sobre Medio Ambiente, Derechos de la Naturaleza, Bienes Naturales Comunes y Modelo Económico: ",
                                   a("HTML", 
                                     href = "https://flamboyant-curran-1c804f.netlify.app/"), "|",
                                   a("PDF", 
                                     href = "http://dx.doi.org/10.13140/RG.2.2.21763.63521")),
                                 p("Primer informe del ",
                                   a("seguimiento a la comisión sobre Derechos Fundamentales", 
                                     href = "https://goofy-einstein-d4dfd8.netlify.app/"))
                                 ),
                          column(6,
                                 h4(strong("Reportes")),
                                 p("[Columna] Nueva Constitución y participación ciudadana, un tremendo desafío sobretodo medioambiental: ",
                                    a("HTML", 
                                      href = "https://mystifying-jackson-5040b6.netlify.app/")),
                                 p("[Columna] Análisis sobre el pluralismos jurídico y la votación sobre sistemas de justicia. ",
                                    a("HTML", 
                                      href = "https://tender-kowalevski-7cf9ff.netlify.app/"))
                          )
                        ),
                        br(),
                        br(),
                        fluidRow(
                          column(4,
                                 p(align = "center",
                                   a(img(src = "logo_casa_comun.png", height = 50, width = 100), href = "https://www.lacasacomun.cl/"))
                          ),
                          column(4,
                                 p(align = "center",
                                   a(img(src= "http://www.academia.cl/2021/admision/logo-uahc-hor.svg", height = 60, width = 175), href = "http://www.academia.cl/"))
                          ),
                          column(4,
                                 p(align = "center",
                                   a(img(src = "https://cl.boell.org/sites/default/files/2019-10/logo-boell-cl-en-city.svg", height = 60, width = 175), href = "https://cl.boell.org/es"))
                          )
                        )
               ),
               tabPanel("Equipo",
                        h4(strong("Equipo del proyecto")),
                        fluidRow(
                          column(4,
                                 h5(strong("Coordinador del proyecto:")),
                                 p(strong("Osvaldo Torres G.")),
                                 p("Doctor en Estudios Latinoamericanos, Magister en Hitoria de Chile y Antropólogo Social de la Universidad de Chile.")
                                 )
                        ),
                        fluidRow(
                          column(4,
                                 h5(strong("Investigador responsable:")),
                                 p(strong("Mauricio Carrasco N. ")),
                                 p("Magister (c) en Sociología de la Universidad Alberto Hurtado y Sociólogo de la Universidad Central, con Postítulo en Procesamiento, Análisis y Visualización de Datos Sociales de la P. Universidad Católica de Chile.")
                                 )
                        ),
                        h5(strong("Investigadoras adjuntas:")),
                        fluidRow(
                          column(4,
                                 p(strong("Estephanie Peñaloza C. ")),
                                 p("Magister en Prensa Escrita y Licenciada en Historia de la P. Universidad Católica de Chile.")
                          ),
                          column(4,
                                 p(strong("Javiera Maturana N. ")),
                                 p("Magister en Psicología Educacional de la P. Universidad Católica de Chile y Psicóloga de la Universidad Central.")
                          )
                        ),
                        h5(strong("Pasantes de investigación: ")),
                        fluidRow(
                          column(4,
                                 p(strong("Paulina Muñoz Ch.")),
                                 p("Magister (c) en Sociología de la Universidad Alberto Hurtado y Socióloga de la P. Universidad Católica del Ecuador.")
                                 ),
                          column(4,
                                 p(strong("Pedro Salvat N.")),
                                 p("Antropólogo Social de la Universidad Academia de Humanismo Cristiano.")
                                 ),
                          column(4,
                                 p(strong("Matias Araya R.")),
                                 p("Estudiante de la Carrera de Ciencias Políticas de la Universidad Academia de Humanismo Cristiano.")
                          )
                        ),
                        fluidRow(
                          column(4,
                                 p(strong("María José Montenegro C.")),
                                 p("Estudiante de la Carrera de Ciencias Políticas de la Universidad Academia de Humanismo Cristiano.")
                          ),
                          column(4,
                                 p(strong("Daniel Parra B.")),
                                 p("Estudiante de la Carrera de Ciencias Políticas de la Universidad Academia de Humanismo Cristiano.")
                          ),
                          column(4,
                                 p(strong("Matias Segovia M.")),
                                 p("Estudiante de la Carrera de Ciencias Políticas de la Universidad Academia de Humanismo Cristiano.")
                          )
                        ),
                        br(),
                        br(),
                        fluidRow(
                          column(4,
                                 p(align = "center",
                                   a(img(src = "logo_casa_comun.png", height = 50, width = 100), href = "https://www.lacasacomun.cl/"))
                          ),
                          column(4,
                                 p(align = "center",
                                   a(img(src= "http://www.academia.cl/2021/admision/logo-uahc-hor.svg", height = 60, width = 175), href = "http://www.academia.cl/"))
                          ),
                          column(4,
                                 p(align = "center",
                                   a(img(src = "https://cl.boell.org/sites/default/files/2019-10/logo-boell-cl-en-city.svg", height = 60, width = 175), href = "https://cl.boell.org/es"))
                          )
                        )
                        )
               )
)