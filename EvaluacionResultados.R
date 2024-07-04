EvaluacionResultados <- function(actual,predicciones,Nombre,Escala,Tipo) 
{
  # Cargar librerías
  if (!require(caret)) {
    install.packages("caret")
  }
  if (!require(e1071)) {
    install.packages("e1071")
  }
  if (!require(ggplot2)) {
    install.packages("ggplot2")
  }
  if (!require(Metrics)) {
    install.packages("Metrics")
  }
  if (!require(glue)) {
    install.packages("Metrics")
  }
  library(caret)
  library(e1071)
  library(ggplot2)
  library(Metrics)
  library(glue)
  
  # Cargar parámetros de reescalado
  scaling_values <- read.csv('scaling_values.csv')
  min_atraccion <- scaling_values$Min[scaling_values$Variable == "atraccion"]
  max_atraccion <- scaling_values$Max[scaling_values$Variable == "atraccion"]
  mean_atraccion <- scaling_values$Mean[scaling_values$Variable == "atraccion"]
  sd_atraccion <- scaling_values$SD[scaling_values$Variable == "atraccion"]
  
  min_generacion <- scaling_values$Min[scaling_values$Variable == "generacion"]
  max_generacion <- scaling_values$Max[scaling_values$Variable == "generacion"]
  mean_generacion <- scaling_values$Mean[scaling_values$Variable == "generacion"]
  sd_generacion <- scaling_values$SD[scaling_values$Variable == "generacion"]
  
  print('Parámetros leídos')
  # Definición funciones de desescalado
  DErange01_A <- function(x) {x * (max_atraccion-min_atraccion) + min_atraccion}
  DErange11_A <- function(x) {(x+1)/2 * (max_atraccion-min_atraccion) + min_atraccion }
  DEcr_A <- function(x) {x*sd_atraccion + mean_atraccion}
  
  DErange01_G <- function(x) {x * (max_generacion-min_generacion) + min_generacion}
  DErange11_G <- function(x) {(x+1)/2 * (max_generacion-min_generacion) + min_generacion}
  DEcr_G <- function(x) {x*sd_generacion + mean_generacion}
  print('Reescalado definido')
  
  # Desescalado de los datos
  if (Tipo=='A') {
   if (Escala=='range01') {
      actual_DE <- DErange01_A(actual) 
      predicciones_DE <- DErange01_A(predicciones) 
  } else if (Escala=='range11') {
      actual_DE <- DErange11_A(actual) 
      predicciones_DE <- DErange11_A(predicciones) 
  } else if (Escala=='cr') {
      actual_DE <- DEcr_A(actual) 
      print('Reescalado hecho')
      predicciones_DE <- DEcr_A(predicciones) 
    }
  }
  else if (Tipo=='G') {
    if (Escala=='range01') {
      actual_DE <- DErange01_G(actual) 
      predicciones_DE <- DErange01_G(predicciones) 
    } else if (Escala=='range11') {
      actual_DE <- DErange11_G(actual) 
      predicciones_DE <- DErange11_G(predicciones) 
    } else if (Escala=='cr') {
      actual_DE <- DEcr_G(actual) 
      predicciones_DE <- DEcr_G(predicciones) 
    }  
  }
  
  conjunto <- data.frame(actual_DE,predicciones_DE)
  
  # Ajustar un modelo de regresión lineal para obtener la pendiente y el intercepto desescalados
  lm_model <- lm(predicciones_DE ~ actual_DE, data = conjunto)
  intercept <- coef(lm_model)[1]
  slope <- coef(lm_model)[2]
  
  # Definir la función para calcular RMSLE
  rmsle <- function(actual, predicted) {
    # Reemplazar valores negativos por 0
    actual[actual < 0] <- 1
    predicted[predicted < 0] <- 1
    # Calcular log(1 + valores)
    log_actual <- log1p(actual)
    log_predicted <- log1p(predicted)
    # Calcular RMSLE
    sqrt(mean((log_actual - log_predicted)^2))
  }
  
  # Valor correlación
  R <- cor.test(actual_DE,predicciones_DE,method='pearson')
  
  # Guardar parámetros de error
  RMSLE <- rmsle(conjunto$actual_DE,conjunto$predicciones_DE)
  R2 <- as.numeric((R$estimate)^2)
  parameters <- data.frame(Nombre,RMSLE,slope,intercept,R2)
  names(parameters) <- c('Model','RMSLE','Slope','Intercept','R2')
  rownames(parameters) <- ''
  write.csv(parameters,file=file.path('output',glue("Param_{Nombre}.csv")),row.names=FALSE)
  
  # Crear el gráfico con leyenda manual
  regression_plot_descaled <- ggplot(conjunto, aes(x = actual_DE, y = predicciones_DE)) +
    geom_point(aes(color = "Predicciones"), alpha = 0.5) +
    geom_smooth(aes(color = "Recta de regresión"), method = "lm", se = FALSE) +
    geom_abline(aes(color = "Valores Reales"), slope = 1, intercept = 0, linetype = "dashed") +
    ggtitle(paste("Resultados", Nombre," \nEcuación de la recta: y = ", round(slope, 2), "x + ", round(intercept, 2))) +
    xlab("Valores Reales") +
    ylab("Predicciones") +
    theme_minimal() +
    theme(plot.title = element_text(hjust = 0.5, size = 12)) +
    coord_fixed(ratio = 1) +
    scale_color_manual(values = c("Predicciones" = "red", "Recta de regresión" = "blue", "Valores Reales" = "green"), 
                       breaks = c("Predicciones", "Recta de regresión", "Valores Reales")) +
    guides(color = guide_legend(title = "Leyenda"))
  # Mostrar la gráfica
  print(regression_plot_descaled)
  
  # LOLLIPOP
  
  # Calcular el error (predicciones_DE - actual_DE)
  errors <- predicciones_DE - actual_DE
  
  # Crear un data frame para el gráfico de lollipop con los valores desescalados
  lollipop_data <- data.frame(
    Valores_Reales = actual_DE,
    Predicciones = predicciones_DE,
    Errores = errors)
  
  # Ajustar un modelo de regresión lineal para los errores
  error_lm_model <- lm(Errores ~ Valores_Reales, data = lollipop_data)
  error_slope <- coef(error_lm_model)[2]
  error_intercept <- coef(error_lm_model)[1]
  
  # Crear el gráfico de lollipop con la línea de regresión de los errores y la línea vertical en x = 0
  lollipop_plot <- ggplot(lollipop_data, aes(x = Valores_Reales, y = Errores)) +
    geom_segment(aes(x = Valores_Reales, xend = Valores_Reales, y = 0, yend = Errores, color = "Segmento"), color = "grey") +
    geom_point(aes(color = "Errores"), size = 3) +
    geom_hline(aes(yintercept = 0, linetype = "Línea de referencia"), color = "black") +
    geom_vline(aes(xintercept = 0, linetype = "Línea de referencia"), color = "black") +
    geom_smooth(aes(color = "Línea de regresión"), method = "lm", se = FALSE) +
    ggtitle("Gráfico de Errores") +
    xlab("Valores Reales") +
    ylab("Errores") +
    theme_minimal() +
    theme(plot.title = element_text(hjust = 0.5, size = 12)) +
    coord_fixed(ratio = 1) +
    scale_color_manual(name = "Leyenda",
                       values = c("Segmento" = "grey", "Errores" = "red", "Línea de regresión" = "blue")) +
    scale_linetype_manual(name = "Leyenda",
                          values = c("Línea de referencia" = "dashed")) +
    guides(color = guide_legend(order = 1), linetype = guide_legend(order = 2))
  
  # Mostrar el gráfico
  print(lollipop_plot)
  
  # Save the plots as a JPG
  jpeg(file=file.path('output',glue("Reg_{Nombre}.jpg")), width = 500, height = 300)
    print(regression_plot_descaled)
  dev.off()
  
  # Save the plots as a JPG
  jpeg(file=file.path('output',glue("Lol_{Nombre}.jpg")), width = 500, height = 450)
      print(lollipop_plot)
  dev.off()
  
}