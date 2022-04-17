# Load packages
library(tidyverse)
library(shiny)
library(shinythemes)
library(readxl)


# Prepare data
constituyentes <- read_excel("constituyentes.xlsx")

datos <- read_excel("constituyentes.xlsx", sheet = 2)

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
        plot(as_factor(df()$voto),
             col = c("red", "orange", "yellow"),
             ylab = "Número de votos")
        )
    
    output$plot2 <- renderPlot({
        
        grafico <- datos %>%
            left_join(df(), by = "nombre") %>%
            select(voto, grupo = input$grupo) %>%
            table()
        
        barplot(grafico, col = c("red", "orange", "yellow"))
        
    })
    
    output$micro <- renderTable(
        datos %>%
            left_join(df(), by = "nombre") %>%
            select(nombre, región = region, distrito, lista, partido, bloque, voto)
    )
    
})