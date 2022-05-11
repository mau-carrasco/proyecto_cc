# Load packages
library(tidyverse)
library(shiny)
library(shinythemes)
library(readxl)


# Prepare data
constituyentes <- readRDS("constituyentes.rds")

datos <- readRDS("datos.rds")

datos <- datos %>%
    mutate(region = factor(region, levels = c("Arica y Parinacota",
                                              "Tarapaca",
                                              "Antofagasta",
                                              "Atacama",
                                              "Coquimbo",
                                              "Valparaiso",
                                              "Metropolitana",
                                              "Libertador General Bernardo O'Higgins",
                                              "Maule",
                                              "Nuble",
                                              "Biobío",
                                              "Araucanía",
                                              "Los Ríos",
                                              "Los Lagos",
                                              "Aysen del General Carlos Ibanez del Campo",
                                              "Magallanes y de la Antartica Chilena",
                                              "Escaños reservados")),
           bloque = factor(bloque, levels = c("Chile Digno",
                                              "Movimientos Sociales Constituyentes",
                                              "Pueblo Constituyente",
                                              "Frente Amplio",
                                              "Colectivo Socialista",
                                              "Pueblos Indígenas",
                                              "Independientes No Neutrales",
                                              "Colectivo del Apruebo",
                                              "Vamos por Chile",
                                              "Sin Bloque")))

constituyentes <- constituyentes %>% mutate(fecha = as.Date(constituyentes$fecha), voto = factor(voto, levels = c("A favor", "Abstención", "En contra")))

# Define server
shinyServer(function(input, output) {
    
    const1 <- reactive({
        filter(constituyentes, fecha== input$fecha)
    })
    observeEvent(const1(), {
        choices <- unique(const1()$tema)
        updateSelectInput(inputId = "tema", choices = choices) 
    })
    
    df <- reactive(filter(const1(), tema %in% c(input$tema)))
    
    output$detalle <- renderText(as.character(df() %>% select(detalle) %>% head(1)))
    
    output$tabla1 <- renderTable(
        df() %>%
            drop_na(voto) %>%
            group_by(voto) %>%
            summarise(n = n()) %>%
            mutate("%" = n/sum(n) * 100) %>%
            janitor::adorn_totals("row")
    )
    
    output$tabla2 <- function(){
        df() %>%
            left_join(datos, by = "nombre") %>%
            select(input$grupo, voto) %>%
            table() %>%
            addmargins(1) %>%
            kableExtra::kable() %>%
            kableExtra::kable_styling("striped", full_width = F)
    }
    
    output$plot1 <- renderPlot(
        df() %>%
            count(voto) %>%
            mutate(prop = n/sum(n)*100) %>%
            ggplot(aes(x = voto,
                       y = n,
                       fill = voto)) +
            geom_col(color = "black") +
            scale_fill_manual(values = c("#ADD8E6", "seagreen1", "#836FFF")) +
            theme_minimal() +
            theme(legend.position = "none")
        )
    
    output$plot2 <- renderPlot({
        
        grafico <- datos %>%
            left_join(df(), by = "nombre") %>%
            select(voto, grupo = input$grupo) %>%
            group_by(grupo, voto) %>%
            summarise(n = n()) %>%
            drop_na() %>%
            mutate(prop = n/sum(n)*100)
        
        grafico %>%
            mutate(grupo = fct_reorder(grupo, desc(grupo))) %>%
            ggplot(aes(x = grupo,
                       y = n,
                       fill = voto)) +
            geom_col(color = "black") +
            scale_fill_manual(values = c("#ADD8E6", "seagreen1", "#836FFF")) +
            labs(x = "") +
            coord_flip() +
            theme_minimal() +
            theme(legend.position = "top",
                  legend.title = element_blank())
            
        
    })
    
    output$micro <- renderTable(
        datos %>%
            left_join(df(), by = "nombre") %>%
            select(nombre, región = region, distrito, lista, partido, bloque, voto)
    )
    
    output$entrada1 <- renderPlot(
        constituyentes %>%
            filter(tema == "Principios Constitucionales, Democracia, Nacionalidad y Ciudadanía (tercer informe): 8.- Votación separada del inciso primero del artículo 3") %>%
            left_join(datos) %>%
            group_by(bloque, voto) %>%
            summarise(n = n()) %>%
            drop_na() %>%
            mutate(prop = round(n/sum(n)*100, 1)) %>%
            ggplot(aes(x = voto, y = n, fill = voto, label = paste0(prop, "%"))) +
            geom_col(position = "dodge",
                     color = "black") +
            geom_text(position = position_dodge(0.9),
                      size = 3,
                      vjust = 0) +
            scale_fill_manual(values = c("#ADD8E6", "seagreen1", "#836FFF")) +
            facet_wrap(~bloque) +
            labs(title = "Artículo 3.- Derecho a una vida libre de violencia de género",
                 subtitle = "Principios Constitucionales, Democracia, Nacionalidad y Ciudadanía (tercer informe)",
                 y = "N° de votos",
                 x = "",
                 caption = "Fuente: www.laconstituyente.cl") +
            ylim(0, 40) +
            theme_test() +
            theme(legend.position = "top",
                  legend.title = element_blank())
    )
    
})