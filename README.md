# Comparison-of-NN-and-SVR-Models-for-Trip-Attraction-and-Generation-Prediction
## Project Description
This project focuses on comparing the effectiveness of two prediction models - Neural Networks (NN) and Support Vector Machines (SVR) - to predict trip attraction and generation in different areas. Using synthetic socio-economic demographic data from 256 zones, both models are trained and evaluated to determine which provides better results. The goal is to identify which of these models offers the highest accuracy in predictions, thus aiding in better urban planning and public policy decision-making. Additionally, a detailed section on possible model improvements is included.

## Project Structure

- **MainFile.Rmd**: Contains the main code, from data loading to creating the ingestion datasets for the models, as well as the final visualization and comparison.
- **NeuralNetworks.Rmd**: Specific code for the implementation and evaluation of the Neural Networks model.
- **SVR.Rmd**: Specific code for the implementation and evaluation of the Support Vector Machines model.
- **EvaluacionResultados.R**: Script for evaluating the model results.
- **EvaluacionResultados_svr.R**: Script for evaluating the SVR model results.

## System Requirements

- **R** (latest version recommended)
- **RStudio**
- Required libraries are included in the scripts and will be installed automatically upon running the code.

## Installation and Execution

1. Clone the repository to your local machine:
   ```sh
   git clone https://github.com/your_user/your_repo.git
2. Open the project in RStudio.
3. Ensure the datasets are in the same directory as the scripts.
4. Create two additional directories within the project directory:
  - output
  - output_svr
5. Run the scripts in the following order:
  - MainFile.Rmd
  - NeuralNetworks.Rmd for the NN model.
  - SVR.Rmd for the SVR model.
6. Uncomment and run the necessary code to save the new datasets.

## Usage

The scripts are executed like any chunk in RStudio. Simply select and run the desired chunks of code.

## Conclusions

Regarding error, NN models tend to perform more consistently and slightly better than SVR models, although the difference is not significant. Both models perform similarly. The best resulting model is a single-layer neural network with 9 neurons, using data in absolute values and a min-max scale of -1 to 1. This model has an RMSLE of 0.6, a regression line of predictions of $y=0.6x+36.633$, and an R² of 0.378. With the same NN architecture but using percentage data and a min-max scale of 0 to 1 for the other features, the best RMSLE obtained is 0.584. No significant differences were found in attraction and generation predictions, although SVR predicts attraction better than NN, contrary to what is observed in generation.

## Improving the Models

To improve the models, the following strategies can be considered:

- Analyze in detail the characteristics of the values with the highest error (deep diving).
- Use real data and increase the amount of data and types of data available.
- Test more NN architectures or a broader grid of hyperparameters for SVR, considering the computational load.
- Use ensemble methods or transfer learning to improve predictions.
- Implement stratification in cross-validation.

## License

Just as described in License section.

## Credits

This project was developed in a group and was proposed and guided by Professor Esteve Codina Sancho from the UPC Postgraduate program, who also provided the synthetic data used. The group members are: Joao Paulo Scabora, Lucas Ezequiel, Julen Larrañaga, Lucía López, and Juan Carlos Rubio.

## Contact

For more information or questions, you can contact me via GitHub or LinkedIn:

- [GitHub](https://github.com/tu_usuario)
- [LinkedIn](https://www.linkedin.com/in/juancarlos-rubio-gil/)

------------------------------------------------------------------------------------------------------------------------------------------------------------
### Archivo README.md (Español)

# Comparación de Modelos NN y SVR para Predicción de Atracción y Generación de Viajes
## Descripción del Proyecto

Este proyecto se centra en comparar dos tipos de modelos de predicción: Redes Neuronales (NN) y Máquinas de Soporte Vectorial (SVR), para prever la atracción y generación de viajes en distintas zonas. Utilizando datos económico-demográficos de 256 áreas, se busca determinar cuál modelo proporciona mayor precisión y efectividad en sus predicciones. Este análisis es crucial para mejorar la planificación urbana y la toma de decisiones en políticas públicas.

## Estructura del Proyecto

- **MainFile.Rmd**: Contiene el código principal, desde la carga de los datos hasta la creación de los datasets de ingesta para los modelos, así como la última visualización y comparación.
- **NeuralNetworks.Rmd**: Código específico para la implementación y evaluación del modelo de Redes Neuronales.
- **SVR.Rmd**: Código específico para la implementación y evaluación del modelo de Máquinas de Soporte Vectorial.
- **EvaluacionResultados.R**: Script para evaluar los resultados del modelo.
- **EvaluacionResultados_svr.R**: Script para evaluar los resultados del modelo SVR.

## Requisitos del Sistema

- **R** (se recomienda la última versión)
- **RStudio**
- Las librerías necesarias están incluidas en los archivos y se instalarán automáticamente al ejecutar el código.

## Instalación y Ejecución

1. Clonar el repositorio en tu máquina local:
   ```sh
   git clone https://github.com/tu_usuario/tu_repositorio.git
2. Abrir el proyecto en RStudio.  
3. Asegurarse de que los datasets estén en la misma carpeta que los scripts.  
4. Crear dos directorios adicionales dentro del directorio del proyecto:  
  - `output`  
  - `output_svr`  
5. Ejecutar los scripts en el siguiente orden:  
  - `MainFile.Rmd`  
  - `NeuralNetworks.Rmd` para el modelo NN.  
  - `SVR.Rmd` para el modelo SVR.  
6. Descomentar y ejecutar los códigos necesarios para guardar los nuevos datasets.  

## Uso

Los scripts se ejecutan como cualquier chunk en RStudio. Simplemente selecciona y ejecuta los chunks de código deseados.  

## Conclusiones

En cuanto al error, las NN suelen tener un desempeño más constante y ligeramente mejor que el SVR, aunque la diferencia no es significativa. Ambos modelos funcionan de manera similar. El mejor modelo resultante es una red neuronal de una sola capa con 9 neuronas, usando datos en valores absolutos y escala min-max de -1 a 1. Este modelo tiene un RMSLE de 0.6, una recta de regresión de las predicciones de \( y = 0.6x + 36.633 \) y un R² de 0.378. Con la misma arquitectura de NN, pero utilizando datos en porcentajes y min-max de 0 a 1 para el resto de características, se obtiene el mejor RMSLE de 0.584. No se encontraron diferencias significativas en las predicciones de atracción y generación, aunque el SVR predice atracción mejor que NN, al contrario de lo observado en generación.

## Mejora de los Modelos

Para mejorar los modelos, se pueden considerar las siguientes estrategias:

- Analizar en detalle las características de los valores que presentan mayor error (deep diving).
- Utilizar datos reales y aumentar la cantidad de datos y tipos de datos disponibles.
- Probar más arquitecturas de NN o un grid más amplio de hiperparámetros para SVR, considerando la carga computacional.
- Usar métodos de ensamblaje de modelos o aprendizaje por transferencia (transfer learning) para mejorar las predicciones.
- Implementar estratificación en la validación cruzada.

## Licencia

La especificada en el apartado de la licencia.

## Créditos

Este proyecto fue desarrollado en grupo y fue propuesto y guiado por el profesor Esteve Codina Sancho del Postgrado de la UPC, quien también proporcionó los datos sintéticos utilizados. Los miembros del grupo son: Joao Paulo Scabora, Lucas Ezequiel, Julen Larrañaga, Lucía López y Juan Carlos Rubio.

## Contacto

Para más información o preguntas, puedes contactarme a través de GitHub o LinkedIn:

- [GitHub](https://github.com/tu_usuario)
- [LinkedIn](https://www.linkedin.com/in/juancarlos-rubio-gil/)
