library(tidyverse)
library(plotly)
library(chilemapas)
library(shiny)
library(shinythemes)

# Define UI for application that draws a histogram
shinyUI(tagList(
    navbarPage(theme = shinytheme("united"),
               # theme = "cerulean",  # <--- To use a theme, uncomment this
               "La Constituyente",
               tabPanel("Presentación",
                        mainPanel(h2("Introducción"),
                                  p("Esta plataforma te permite conocer de forma rápida, clara y objetiva el desempeño de las y los constituyentes en la Convención en temas que son de alto interés para el futuro del país."),
                                  p("Las dimensiones a las que damos seguimiento en la Convención Constitucional, en sus posiciones y votaciones, son:"),
                                  p("a) Estado plurinacional e interculturalidad;"),
                                  p("b) Derechos sociales;"),
                                  p("c) Derechos de las mujeres y disidencias sexuales;"),
                                  p("d) Derechos de la naturaleza y medioambiente;"),
                                  p("e) Democracia directa;"),
                                  p("También puedes tener información, en las dimensiones señaladas, de las propuestas que formuló cada constituyente previo a su elección. Si quieres, puedes seleccionar a cada una/o de ellos, por distrito o lista a la que pertenecen."),
                                  p("La plataforma también te permitirá tener los resultados de aquellas votaciones que tengan mayor impacto público y que no necesariamente correspondan a las dimensiones señaladas. El criterio que utilizamos para su selección es la importancia que se le otorga en el debate público."),
                                  br(),
                                  h2("Las dimensiones de seguimiento"),
                                  p("Seleccionamos aquellas dimensiones que nos parecieron muy importantes, al estar relacionadas con las demandas levantadas por la población y que la rebelión social, iniciada el 18 de octubre, ha puesto en la agenda constitucional. Una limitante de esto es, también, la capacidad instalada para abarcar una mayor cantidad de dimensiones. Las seleccionadas permiten configurar un nuevo tipo de Estado, una nueva concepción y relación con la naturaleza, una sociedad sustentada en el respeto a la igualdad y dignidad entre los seres humanos con independencia de su origen, su pueblo, género u opción sexual y puede asegurar constitucionalmente el ejercicio de los derechos sociales que dan sustento a las libertades y participación de la población."),
                                  p("Hemos distinguido para cada dimensión algunos indicadores a seguir, que son de carácter cualitativo:"),
                                  img(src = "tabla.png"),
                                  br(),
                                  h2("Quiénes somos"),
                                  p("Somos un equipo de la fundación La Casa Común que está interesado en realizar el seguimiento a la Convención Constitucional, pues consideramos que es importante que el público y las organizaciones sociales jueguen un rol activo en la participación, diálogo e interpelación con sus constituyentes electos en sus distritos. Para tener una mejor participación, consideramos que es fundamental contar con la información de manera simple, ordenada, comprensible y a tiempo para que sea útil."),
                                  p("La Casa Común ha desarrollado un esfuerzo por aportar contenidos al proceso constituyente y queremos ser un canal para que las y los constituyentes pueden disponer de la información del desempeño de sus colegas en los temas que hemos definido, y a la vez las organizaciones y el público en general pueda monitorearlos en las posiciones que van adoptando."),
                                  p("Nos apoyan en este esfuerzo la Fundación Heirich Boell, la que viene desarrollando un importante esfuerzo por democratizar el conocimiento en temas relevantes, apoyando acciones de la sociedad civil por el cambio de enfoque en los temas medioambientales, de un feminismo latinoamericano y en temas de derechos humanos, entre otros."),
                                  p("Hemos firmado un convenio con la Universidad Academia de Humanismo Cristiano, para fortalecer nuestra capacidad de seguimiento y contamos con el apoyo de ellos en la difusión de los resultados que se van presentando."),
                                  p("Tenemos una alianza con El Desconcierto, que es un destacado e interesado medio de comunicación en los temas de la Convención Constitucional. El Desconcierto, en la práctica, forma parte del proceso que dio origen al despliegue de los movimientos sociales que presionaban por una nueva constitución y un Chile más igualitario y libertario."),
                                  br()
                        )),
               tabPanel("Votaciones",
                        sidebarPanel(
                            radioButtons("lugar", "Lugar de votación:",
                                         c("Plenaria" = "norm",
                                           "Por comisiones" = "unif")),
                            selectInput("materia", "materia de votación", constituyentes$materia, selected = T),
                            tableOutput("detalle"),
                            selectInput("region", "Región (seleccione una o más)", constituyentes$region, c("Selecciones una o más" = "") ,multiple = T)
                        ),
                        mainPanel(
                            tabsetPanel(type = "tabs",
                                        tabPanel("Resultado" , plotlyOutput("plot")),
                                        tabPanel("Listas", plotlyOutput("listas")),
                                        tabPanel("Mapa", plotlyOutput("mapa")),
                                        tabPanel("Detalle", dataTableOutput("tabla")))
                        )
               ),
               tabPanel("Programas Convencionales", "This panel is intentionally left blank"),
               tabPanel("Reportes", "This panel is intentionally left blank"),
               tabPanel("Preguntas frecuentes",
                        mainPanel(h4("1.- ¿Con qué criterios definieron las dimensiones e indicadores?"),
                                  p("Para las dimensiones e indicadores utilizamos como base las definiciones de los tratados internacionales de derechos humanos y la Convención sobre Biodiversidad. Además, complementamos el listado de conceptos clave con literatura académica actualizada, que se cita en la tabla de dimensiones seleccionadas por el proyecto para dar seguimiento a los temas de la Convención."),
                                  br(),
                                  h4("2.- ¿Con qué criterios seleccionaron las dimensiones?"),
                                  p("Con los criterios expuestos en la pestaña “Presentación”. El proyecto tiene una limitación financiera y temporal que impedía abarcar toda la discusión de la Convención. Por otra parte, nos interesaba abordar aquellos temas sustantivos que están en el cambio de fondo de la relación entre las personas y de éstas con la naturaleza. Con esas consideraciones creemos estar dando cuenta la profundidad del cambio cultural, social, político e institucional que pueda producir la Convención."),
                                  br(),
                                  h4("3.- ¿Cómo configuraron el ordenamiento de las Listas en la Convención?"),
                                  p("Decidimos organizar a las y los convencionales según las listas en las que fueron electos. Como hubo una gran cantidad de independientes electos en lista o en listas de independientes, pero que han ido alineándose según sus aproximaciones sea ideológicas o temáticas se han reconfigurado muchos alineamientos. Como la Convención Constitucional tampoco es un parlamento tradicional, incorporamos “nuevas listas” según lo declarado por sus protagonistas. Esto puede sufrir nuevas modificaciones en el proceso de debates. Las listas que no tienen cambios son aquellas que se han mantenido estables: Colectivo Socialista (ex Lista Apruebo que fueron en cupo partido Socialista o como Independiente en cupo PS), Lista Apruebo Dignidad (que reúne a dos coaliciones el Frente Amplio con sus partidos legales Revolución Democrática, Convergencia Social y Comunes, más independientes y Chile Digno con el partido Comunista y Federación Regionalista Verde Social) Lista Independientes No Neutrales (que trabaja en base a consensos propios y libertad de voto), Lista Chile Vamos (que ha mantenido su funcionamiento como coalición entre Unión Demócrata Independiente, Renovación Nacional y Evópoli, más independientes), Lista Pueblo Constituyente (que proviene de la Lista del Pueblo), la Lista Movimientos Sociales Constituyentes (personas electas en sus regiones como independientes). Lista Colectivo del Apruebo conformada recientemente (reúne a no socialistas de Lista del Apruebo más independientes). Existen algunos constituyentes no incorporados a listas, pues no han expresado adhesión o integración a sus grupos de trabajo."),
                                  p("Es importante señalar que esta conformación puede ser dinámica, por lo que aquellas personas interesadas en el desempeño de las coaliciones pueden consultar también por desempeño de cada constituyente, que está descrito según su partido y coalición por la que fue electo."),
                                  br(),
                                  h4("4.- ¿Cómo puedo conocer la forma de votación de las y los constituyentes?"),
                                  p("Tienes dos formas: una, es yendo al listado de constituyentes los que están con colores según su lista y distrito. Puedes seleccionar de la tabla la forma de visualizarlo como individuo, por distrito y por lista. También puedes desde los gráficos de votación aplicar el zoom (arriba a la derecha del gráfico aparece una barra, selecciona zoom) sobre la barra de apruebo, rechazo o abstención y aparecerá con más claridad."),
                                  br(),
                                  h4("5.- ¿Cómo puedo capturar un gráfico y enviarlo por whatsap u otra red social?"),
                                  p("Debes ir a la barra superior derecha del gráfico y presionar el botón download. Luego, se descargará el gráfico o mapa en formato png para que puedas compartirlo por redes sociales o insertarlo en algún documento Word o PDF."),
                                  br())),
               tabPanel("Contacto",
                        mainPanel(h2("Equipo del Proyecto"),
                                  h4("Jefe del Proyecto"),
                                  p("- Osvaldo Torres"),
                                  p(" Antropólogo, Magister en Historia y Doctor en Estudios Latinoamericanos de la Universidad de Chile"),
                                  h4("Investigadores(as)"),
                                  p("- Mauricio Carrasco"),
                                  p(" Sociólogo, Diplomado en Análisis de Datos Avanzados de la P. Universidad Católica de Chile y estudiante del Magister en Sociología de la Universidad Alberto Hurtado"),
                                  p("- Estephanie Peñaloza"),
                                  p(" Licenciada en Historia y Periodista, Magister en Prensa Escrita de la P. Universidad Católica de Chile"),
                                  p("- Javiera Maturana"),
                                  p(" Psicóloga y Candidata a Magister en Psicología Educacional de la P. Universidad Católica de Chile"),
                                  h4("Asistentes de investigación"),
                                  p("- Estudiante UAHC 1"),
                                  p("- Estudiante UAHC 2"),
                                  p("- Estudiante UAHC 3"),
                                  h2("Correo de contacto"),
                                  p("laconstituyente@lacasacomun.cl"),
                                  p("La Casa Común, es una fundación sin fines de lucro, TU aporte es necesario. www.lacasacomun.cl")))
    )
))
