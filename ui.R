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
                        h4(strong("Novedades de la última semana:")),
                        fluidRow(column(12,
                                        p("En sus últimas siete semanas de funcionamiento las comisiones que componen la Convención Constitucional ya alistan los últimos detalles de la propuesta que deberán presentar a la ciudadanía y el cierre de su trabajo, el que deberá culminar el próximo 5 de julio con la entrega del borrador final."),
                                        )),
                        fluidRow(column(6,
                                        strong("Comisión Preámbulo:"),
                                        p("Una de las comisiones más avanzadas es la de Preámbulo. Este jueves, los integrantes de la instacia despacharon al pleno la propuesta de introducción de la nueva Constitución, cuyos párrafos fueron redactados por un grupo de nueve convencionales."),
                                        p("La propuesta es la siguiente:"),
                                        p(align = "center", em("<<Nosotras y nosotros, el pueblo de Chile, conformado por diversas naciones, nos otorgamos libremente esta Constitución, acordada en un proceso participativo, paritario y democrático.")),
                                        p(align = "center", em("Considerando los dolores del pasado y tras un estallido social, enfrentamos las injusticias y demandas históricas con la fuerza de la juventud, para asumir esta vía institucional a través de una Convención Constitucional ampliamente representativa.")),
                                        p(align = "center", em("Con ello, hemos decidido mirar hacia el futuro con esperanza y cambiar nuestro destino sin importar el origen, condición o creencias de cada cual; para construir una sociedad justa, consciente de su relación indisoluble con la naturaleza amenazada por la crisis climática, que promueva una cultura de paz y diálogo, con un compromiso profundo por los Derechos Humanos, la justicia, igualdad y libertad.")),
                                        p(align = "center", em("De esta manera, en ejercicio del poder constituyente, adoptamos la siguiente Constitución Política de la República de Chile.>>")),
                                        ),
                                 column(6,
                                        strong("Comisión de normas transitorias:"),
                                        p("Este jueves la Comisión de Normas Transitorias deliberó sobre tres puntos controversiales: el quórum para que el actual Congreso pueda reformar la nueva Constitución, el futuro de los senadores y la opción de que el Ejecutivo legisle vía Decretos por Fuerza de Ley."),
                                        p("Los convencionales de la comisión aprobaron la indicación que congela el mecanismo de reforma de la eventual nueva Constitución hasta 2026, fijando un quórum de 2/3 para cualquier modificación que quiera hacer el actual Congreso. Además, la enmienda visada estableció que <<las normas de reforma a la Constitución establecidas en esta Constitución entrarán en vigencia el 11 de marzo de 2026.>>"),
                                        p("Asimismo, la comisión aprobó la enmienda que pone fin al Senado en 2026 y que propone que los parlamentarios recientemente electos no se integren de manera automática a la Cámara de las Regiones. <<Todos los integrantes del Senado terminarán su mandato el 11 de marzo de 2026, independiente de la fecha de su elección>>, dice una de las indicaciones aprobadas."),
                                        p("En cuanto a los Decretos por Fuerza de Ley Adecuatorios, dos grupos de convencionales propusieron su utilización en dos casos particulares. Uno apunta a aplicar decretos si en 18 meses no se promulga una ley integral sobre vivienda y urbanismo y el otro pretende hacer lo mismo si en dos años no se aprueban los proyectos relativos a seguridad social. Ambas propuestas serán discutidas durante las próximas semanas en la comisión.")
                                        )),
                        fluidRow(
                          column(6,
                                 strong("Comisión de Armonización:"),
                                 p("Este martes la Secretaría Técnica de la comisión de Armonización elaboró una propuesta para la distribución de los 499 artículos que componen el borrador de la nueva Constitución. El documento fue visado por la instancia y, por lo tanto, se convirtió en la base sobre la que trabajarán los convencionales."),
                                 p("Durante el martes y miércoles la comisión recibió a un grupo de expertos constitucionales que dieron sus recomendaciones sobre el texto y el proceso de armonización como insumo para la redacción de enmiendas que los convencionales podían presentar hasta las 22.00 horas de este viernes. Las indicaciones fueron votadas este sábado por la comisión."),
                                 strong("Debate:"),
                                 p("Las disposiciones transitorias de la Convención Constitucional han generado gran interés y discusión en la opinión pública. Esta semana, el convencional Fernando Atria fue entrevistado en CNN sobre esta y otras materias. Te invitamos a ver la entrevista para mantenerte informado y contribuir al debate público sobre la eventual nueva constitución."),
                                 ),
                          column(6,
                                 HTML('<iframe width="560" height="315" src="https://www.youtube.com/embed/c4-997Zg8CI" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>')
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
               tabPanel("Votaciones",
                        h4(strong("Votaciones celebradas en el pleno de la CC")),
                        sidebarPanel(align="center",
                                     selectInput("fecha",
                                                 "Fecha",
                                                 choice = unique(constituyentes$fecha),
                                                 selected = "2022-05-14"),
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
                                                                "Bloque político interno" = "bloque",
                                                                "Genero" = "sexo"))
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
               tabPanel("Datos",
                        h4(strong("Bases de datos")),
                        p("En esta sección encontrarás la base de datos con la información de las y los convencionales constituyentes y la base de datos con las votaciones celebradas en el pleno de la Convención Constitucional."),
                        fluidRow(
                          column(5,
                                 h5(strong("Base de datos con información de las y los convencionales constituyentes: ")),
                                 strong("Base de datos:"),
                                 p(downloadLink("constituyentes_sav", "SPSS"), " | ", downloadLink("constituyentes_dta", "STATA"), " | ", downloadLink("constituyentes_rds", "R")),
                                 ),
                          column(5,
                                 h5(strong("Base de datos con información de las votaciones celebradas en el pleno de la Convención Constitucional: ")),
                                 strong("Base de datos: "),
                                 p(downloadLink("votos_sav", "SPSS"), " | ", downloadLink("votos_dta", "STATA"), " | ", downloadLink("votos_rds", "R")),
                                 )
                        ),
                        fluidRow(
                          column(12,
                                 h5(strong("Normas de uso de la base de datos:")),
                                 p("Te recordamos que el uso de estas bases de datos debe ir acompañado de la siguiente cita: "),
                                 p("Fundación la Casa Común & Universidad Academia de Humanismo Cristiano. (2022).", em("Observatorio de la Convención Constitucional de Chile: LaConstituyen.CL."), " Disponible en: www.laconstituyente.cl")
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