library(tidyverse)
library(plotly)
library(chilemapas)
library(shiny)
library(shinythemes)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    df <- reactive(filter(constituyentes, materia==input$materia ))
    mapa <- reactive(constituyentes %>%
                         select(materia, region,codigo_distrito = distrito, voto) %>%
                         filter(materia == input$materia,
                                region %in% c(input$region)) %>%
                         group_by(region,codigo_distrito, voto) %>%
                         summarise(frecuencia = n()) %>%
                         mutate(porcentaje = frecuencia/sum(frecuencia)*100) %>% 
                         left_join(distritos, by = "codigo_distrito") %>%
                         drop_na())
    tabla <- reactive(constituyentes %>%
                          select(region, nombre, apellido, lista, partido, distrito, materia, voto) %>%
                          filter(materia == input$materia,
                                 region %in% c(input$region)))
    output$detalle <- renderTable(df() %>% select(detalle) %>% head(1))
    output$plot <- renderPlotly(ggplotly(
        df() %>%
            drop_na(voto) %>%
            group_by(voto) %>%
            summarise(frecuencia = n()) %>%
            mutate(porcentaje = frecuencia/sum(frecuencia)*100) %>%
            ggplot(aes(x = voto, y = frecuencia, fill = voto, text = paste0("Opción: ", voto,
                                                                            "<br>Número de votos: ", frecuencia,
                                                                            "<br>Porcentaje: ", round(porcentaje), "%"))) +
            geom_col() +
            labs(title = "Resultados de la Votación",
                 y = "N° de votos",
                 x = "Opciones") +
            scale_fill_brewer(palette = "YlOrRd", direction = -1) +
            theme_bw(),
        tooltip="text") %>% layout(showlegend = T))
    output$listas <- renderPlotly(ggplotly(
        df() %>%
            drop_na(voto) %>%
            group_by(bloque, voto) %>%
            summarise(frecuencia = n()) %>%
            mutate(porcentaje = frecuencia/sum(frecuencia)*100) %>%
            ggplot(aes(x = voto, y = frecuencia, fill = voto, text = paste0("Opción: ", voto,
                                                                            "<br>Número de votos: ", frecuencia,
                                                                            "<br>Porcentaje: ", round(porcentaje), "%"))) +
            geom_col() +
            facet_wrap(~ bloque, nrow = 2) +
            labs(title = "Resultados de la votación por bloque político",
                 y = "N° de votos",
                 x = "Opciones") +
            scale_fill_brewer(palette = "YlOrRd", direction = -1) +
            theme_bw(),
        tooltip="text") %>% layout(showlegend = FALSE))
    output$mapa <- renderPlotly({ggplotly(
        ggplot(mapa()) +
            geom_sf(aes(fill = round(porcentaje), geometry = geometry, text = paste0("Región: ", region,
                                                                                     "<br>Distrito: ", codigo_distrito,
                                                                                     "<br>Porcentaje de votos a favor: ", round(porcentaje), "%"))) +
            labs(fill = "% de de votos a favor") +
            scale_fill_gradient(low="yellow", high="red", limits=c(0, 100)) +
            theme_void(), tooltip="text")
    })
    
    output$tabla <- renderDataTable(tabla(),options = list(
        pageLength = 10))
})
