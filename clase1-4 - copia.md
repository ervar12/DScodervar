---
title: "Clase 1.3 - Rango de una matriz"
output: html_notebook
---

\newcommand{\R}{\mathbb{R}}
\newcommand{\E}{\mathcal{E}}
\newcommand{\B}{\mathcal{B}}
\DeclareMathOperator{\rank}{rango}
\DeclareMathOperator{\proj}{proj}

$$
\newcommand{\mathbb{R}}{\mathbb{R}}
\newcommand{\mathcal{E}}{\mathcal{E}}
\newcommand{\mathcal{B}}{\mathcal{B}}
\DeclareMathOperator{\mathop{\mathrm{rango}}}{rango}
\DeclareMathOperator{\mathop{\mathrm{proj}}}{proj}
$$

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## Rango de una matriz

Para saber si un sistema de ecuaciones puede tener solución única, infinitas soluciones o ninguna solución, calculamos el **rango** de la matriz $A$. Pensando las filas de una matriz como ecuaciones, el rango de la matriz nos indica cuantas ecuaciones "independientes" tenemos.

### Espacio vectorial generado por vectores

Dado un conjunto $\{v_1, \dots, v_m\}$ de vectores en $\mathbb{R}^n$, definimos el espacio vectorial generado por estos vectores como

$$
V = \left\{\sum_{i=1}^m a_i v_i : a_i \in \mathbb{R}\ \text{ para todo } 1 \le i \le m\right\}
$$

**Ejemplo**

$$
V = \langle (1,2,3), (0, 2, 1) \rangle = \{a_1(1,2,3) + a_2(0,2,1)\} 
$$

Tomando $a_1 = 1$ y $a_2 = -1$ obtenemos que $(1,0,2) \in V$.

### Vectores linealmente independientes

Decimos que un conjunto $\{v_1, \dots, v_m\}$ de vectores en $\mathbb{R}^n$ es linealmente independiente si la única elección de coeficientes para los cuales

$$\sum_{i=1}^m a_i v_i = 0$$

es $a_i = 0$ para todo $1 \le i \le m$.

#### Ejemplos

-   $v_1 = (1,0,0)$, $v_2 = (0, 1, 0)$ y $v_3 = (0, 0, 1)$ son linealmente independientes.

-   $v1 = (1,0,1)$, $v_2 = (0, 1, 2)$ y $v_3 = (1, 2, 5)$ son linealmente dependientes, porque $v_3 = v_1 + 2v_2$. O equivalentemente, $v_1 + 2v_2 - v_3 = 0$.

### Rango de una matriz

El rango de una matriz es la máxima cantidad de filas o columnas linealmente independientes que posee la matriz.

**Propiedad.** La máxima cantidad de filas linealmente independientes de una matriz coincide con la máxima cantidad de columnas linealmente independientes.

Por lo tanto, no es necesario distintiguir rango-fila de rango-columna, y hablamos simplemente de *rango*.

#### Ejemplos

-   $\mathop{\mathrm{rango}}\left(\begin{pmatrix}1&4&7\\0&2&6\end{pmatrix}\right) = 2$

-   $\mathop{\mathrm{rango}}\left(\begin{pmatrix}1&0&1 \\ 0&1&2 \\ 1 & 2 & 5\end{pmatrix}\right) = 2$

### ¿Cómo calcular el rango?

Para calcular el rango de una matriz, triangulamos la matriz y contamos cuántas filas no nulas quedan.

**Propiedad.** El espacio vectorial generado por las filas de una matriz antes o después de triangular es el mismo.

```{r}
library(matlib)  # Cargamos el paquete matlib con funciones matriciales para  enseñanza de álgebra lineal

A = matrix(c(1,0,1, 0, 1, 2,1,2,5), byrow=TRUE, nrow = 3)
gaussianElimination(A)

B = matrix(c(1,2,3,4,5,6,7,8,9), nrow=3, byrow = TRUE)
gaussianElimination(B)
```

También podemos calcular el rango utilizando el comando `R` en **R**.

```{r}
R(A)
R(B)
det(A)
```

![spiderman](img/meme-spiderman.jpg)

### Sistemas de ecuaciones y rango de matrices

-   Si $\mathop{\mathrm{rango}}(A)$ es igual a la cantidad de filas, el sistema $Ax = b$ siempre tiene solución. Todas las ecuaciones son independientes entre sí.

-   Si la matriz $A$ es cuadrada y $\mathop{\mathrm{rango}}(A)$ es igual a la cantidad de filas, decimos que $A$ tiene rango máximo. En este caso, el sistema $Ax = b$ tiene solución única para todo $b$.

### Rango de un producto de matrices

Dadas matrices $A \in \mathbb{R}^{m \times n}$ y $B \in \mathbb{R}^{n \times p}$,

-   $\mathop{\mathrm{rango}}(A) = \mathop{\mathrm{rango}}(A^T) = \mathop{\mathrm{rango}}(A^TA) = \mathop{\mathrm{rango}}(AA^T)$

-   $\mathop{\mathrm{rango}}(AB) \le \min\{\mathop{\mathrm{rango}}(A), \mathop{\mathrm{rango}}(B)\}$.

-   Si $B \in \mathbb{R}^{n \times n}$, y $B$ tiene rango máximo, entonces $\mathop{\mathrm{rango}}(AB) = \mathop{\mathrm{rango}}(A)$.

Idea de las demostración: las filas de $AB$ son combinaciones de las filas de $B$ y las columnas de $AB$ son combinaciones de las columnas de $A$.
