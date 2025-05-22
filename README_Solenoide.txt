
README – Simulación del Campo Magnético de un Solenoide en MATLAB

Este programa en MATLAB simula el comportamiento del campo magnético generado por un solenoide (una bobina de varias vueltas por donde circula corriente). Utiliza la ley de Biot–Savart para calcular el campo en diferentes puntos del espacio y representa visualmente tanto el solenoide como el campo generado.

¿Qué hace este código?

1. Modela un solenoide como una serie de vueltas circulares apiladas en el eje Z.
2. Calcula el campo magnético en una malla tridimensional de puntos, tomando en cuenta la contribución de cada segmento de corriente.
3. Visualiza:
   - El solenoide en 3D.
   - El campo magnético en el plano XZ, mostrando la dirección y magnitud del campo con colores y líneas de flujo.

Explicación paso a paso

1. Definición de parámetros físicos y geométricos
- nl, N: número de capas (vueltas) del solenoide y número de segmentos por vuelta.
- R: radio del solenoide.
- I: corriente eléctrica.
- mo: permeabilidad magnética del vacío.
- km: constante calculada a partir de mo e I, usada en la ley de Biot–Savart.
- sz: separación entre capas (altura del solenoide).

2. Generación de la geometría del solenoide
- Se calculan las coordenadas (x, y) de cada punto de la espira circular.
- También se calcula el vector tangente (dx, dy) en cada punto, que representa la dirección del segmento de corriente.
- Se repite la espira en diferentes alturas para formar las capas del solenoide.

3. Visualización del solenoide
- Se usa quiver3 para graficar flechas que indican la dirección de la corriente en cada segmento.

4. Preparación de la malla para el cálculo del campo
- Se define una cuadrícula tridimensional de puntos donde se calculará el campo magnético.

5. Cálculo del campo magnético con la ley de Biot–Savart
- Para cada punto en la malla, se suman las contribuciones del campo magnético generadas por todos los segmentos del solenoide.
- Se hace uso del producto cruzado entre el vector de corriente dl y el vector de posición r desde el segmento al punto de observación.

6. Visualización del campo magnético
- Se selecciona un corte del campo en el plano XZ (manteniendo constante el eje Y).
- Se grafica la magnitud del campo con colores (pcolor) y las líneas de flujo con streamslice.
- Se aplica un sombreado suave y un mapa de colores para mejorar la visualización.

Resultado final

El código genera dos figuras:

- Una vista tridimensional del solenoide con sus segmentos de corriente.
- Una imagen del campo magnético sobre un plano vertical (XZ), mostrando la intensidad del campo con colores y su dirección con líneas.

Observaciones

Este programa es útil para visualizar cómo se genera el campo magnético alrededor de un solenoide ideal, y cómo cambia la dirección e intensidad del campo en distintas regiones del espacio.


==================================================
Física detrás del código – Campo Magnético de un Solenoide
==================================================

¿Qué es un solenoide?

Un solenoide es una bobina de alambre enrollado en espiral. Cuando por ella circula corriente eléctrica, genera un campo magnético. Este campo es fuerte y uniforme en su interior, y más débil y disperso en el exterior.

Ley de Biot–Savart (explicación simple)

La ley de Biot–Savart permite calcular el campo magnético generado por un pequeño segmento de alambre que conduce corriente. Dice que cada tramo contribuye un poco al campo total, dependiendo de su orientación y su distancia al punto donde queremos saber el campo.

La fórmula es:

    dB = (μ₀ * I / 4π) * (dl × r̂) / |r|²

En este código, se usa una forma equivalente:

    dB = (μ₀ * I / 4π) * (dl × r) / |r|³

Donde:
- μ₀ es la permeabilidad del vacío.
- I es la corriente eléctrica.
- dl es un pequeño vector que indica la dirección del alambre.
- r es el vector desde el segmento hasta el punto de observación.
- × representa el producto cruzado, que da la dirección perpendicular.

¿Qué hace el código con esta ley?

1. Divide cada vuelta del solenoide en muchos segmentos pequeños.
2. Para cada punto del espacio (en una malla tridimensional), calcula la suma de los campos magnéticos generados por cada segmento.
3. Suma todas las contribuciones para obtener el campo total en ese punto.
4. Visualiza el campo resultante para que podamos observar cómo fluye.

¿Qué muestra la simulación?

- Dentro del solenoide, el campo magnético es intenso y casi uniforme.
- Fuera del solenoide, el campo es más débil y con líneas curvas.
- Esto refleja cómo se comportan los campos magnéticos reales en este tipo de dispositivos.

Importancia

Esta simulación ayuda a entender mejor conceptos clave del electromagnetismo y tiene aplicaciones prácticas en ingeniería eléctrica, medicina (resonancia magnética), electrónica y física teórica.
