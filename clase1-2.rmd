---
title: "Clase 1 - Vectores y matrices"
output: 
  html_notebook
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

# Vectores y matrices

## Vectores

Denotamos $\mathbb{R}^n$ al espacio vectorial de $n$ dimensiones.

-   $\mathbb{R}^2$ es el plano coordenado.

-   $\mathbb{R}^3$ es el espacio de 3 dimensiones.

Un vector es un elemento $v \in \mathbb{R}^n$.

### Ejemplos

-   $v = (1,2) \in \mathbb{R}^2$.

-   $u = (2, -1, \pi, 3/2) \in \mathbb{R}^4$.

```{r}
# Definimos vectores en R con el comando c()

v = c(1,2)
print(v)

u = c(2, -1, pi, 3/2)
print(u)


```

## Matrices

Denotamos $\mathbb{R}^{m \times n}$ al espacio de matrices de $m$ filas y $n$ columnas (es un espacio vectorial de $m \times n$ dimensiones).

### Ejemplos

-   $\begin{pmatrix} 1 & 2 & 3 \\ 4 & 5 & 6 \end{pmatrix} \in \mathbb{R}^{2 \times 3}$

-   $\begin{pmatrix} 1 \\ 7 \\ 0.6 \\ -1 \end{pmatrix} \in \mathbb{R}^{4 \times 1}$

Es común considerar a los vectores en $\mathbb{R}^n$ como matrices columna. Es decir, al vector $v=(1,2,3)$ lo pensamos como matriz $\begin{pmatrix} 1 \\ 2 \\ 3\end{pmatrix}$ cuando trabajamos con matrices.

### Matrices en R

En **R** definimos matrices usando el comando `matrix` o el comando `array`. Los parámetros que debemos pasar son distintos, pero el objeto que generan es el mismo.

```{r}
A = matrix(c(1,2,3,4,5,6), nrow = 3)
print(A)   # Observar que los datos se están ingresando por columna.


B = array(c(1, 7, 0.6, -1), dim = c(4,1))
print(B)
```

Si queremos ingresar datos por fila, usamos la opción `byrow = true`.

```{r}
M = matrix(c(1,2,3,4,5,6), nrow = 3, byrow = TRUE)
print(M)
```

También podemos definir matrices pegando vectores.

```{r}
v1 = 1:3   # Vector con los números del 1 al 3
v2 = c(4,5,6)

# Usamos rbind para pegar filas y cbind para pegar columnas
C = rbind(v1, v2)
print(C)

D = cbind(B, 1:4)
print(D)

```

Podemos acceder a las casillas de un vector o matriz usando los índices de las casillas.

```{r}
print(A)
print(A[3,2])

print(v1[2])
print(A[3,2])
print(D[3,1])

```

## Resolución de sistemas de ecuaciones por triangulación (eliminación gaussiana)

La eliminación gaussiana es un método muy eficiente para resolver sistemas de ecuaciones lineales en forma directa (es decir, sin utilizar métodos iterativos que aproximan la solución).

A modo de ejemplo, resolvemos el siguiente sistema de ecuaciones.

$$
\left\{ {\begin{alignedat}{7}
x&&\;+\;&&5y&&\;+\;&&5z&&\;=\;&&2&\\
2x&&\;+\;&&2y&&\;-\;&&3z&&\;=\;&&-1&\\
-x&&\;-\;&&9y&&\;+\;&&2z&&=\;&&9&.
\end{alignedat}} \right.
$$

A partir del sistema, construimos la *matriz ampliada* de coeficientes y términos independientes: $$
\left(
\begin{array}{rrr|r}1&5&5&2\\2&2&-3&-1\\-1&-9&2&9\end{array}
\right)
$$ Triangulamos la matriz realizando operaciones de filas. Las operaciones permitidas (que no afectan las soluciones del sistema) son:

-   Sumarle o restarle a una fila un múltiplo de otra fila
-   Intercambiar dos filas
-   Multiplicar una fila por un escalar distinto de 0.

El algortimo de eliminación gaussiana consiste en triangular o escalonar la matriz obteniendo 0's abajo de los elementos de la diagonal, o más generalmente, produciendo que en cada fila la cantidad de 0's iniciales sea mayor que en la fila anterior.

Realizamos las siguientes operaciones: $$
\left(
\begin{array}{rrr|r}1&5&5&2\\2&2&-3&-1\\-1&-9&2&9\end{array}
\right)
\xrightarrow{f_2 - 2 f_1 \rightarrow f_2} 
\left(
\begin{array}{rrr|r}1&5&5&2\\0&-8&-13&-5\\-1&-9&2&9\end{array}
\right)
\rightarrow \\
\xrightarrow{f_3 + f_1 \rightarrow f_3} 
\left(
\begin{array}{rrr|r}1&5&5&2\\0&-8&-13&-5\\0&-4&7&11\end{array}
\right)
\xrightarrow{f_3 - \frac12 f_2 \rightarrow f_3} 
\left(
\begin{array}{rrr|r}1&5&5&2\\0&-8&-13&-5\\0&0&\frac{27}{2}&\frac{27}{2}\end{array}
\right)
$$Ahora podemos obtener los valores de $x, y, z$ por "sustitución hacia atrás". Primero calculamos $z = 1$, luego $y = -1$ y finalmente $x = 2$. La segunda ecuación queda

$$
-8y -13 \cdot (1)=-5
$$

entonces, $y = -1$.

En **R** podemos realizar eliminación gaussiana con el comando `gaussianElimination` .

```{r}
library(matlib)  # Cargamos el paquete matlib con funciones matriciales para  enseñanza de álgebra lineal

A = matrix(c(1,5,5,2,2,2,-3,-1,-1,-9,2,9), byrow=TRUE, nrow = 3)
gaussianElimination(A)
```

El comando `gaussianElimination` hizo eliminación hacia abajo y hacia arriba, de esta forma podemos leer directamente las soluciones.

También podemos usar el comando `echelon` que con la opción `verbose = TRUE` nos muestra todos los pasos de la triangulación... ¡aunque usted no lo crea!

```{r}
echelon(A, verbose=TRUE, fractions=TRUE) # reduced row-echelon form

```

Si le damos la matriz $A$ y el vector $b$ por separado, ¡hasta nos construye la matriz ampliada!

```{r}
A = matrix(c(1,5,5,2,2,-3,-1,-9,2), byrow=TRUE, nrow = 3)
b = c(2, -1, 9)
echelon(A, b, verbose=TRUE, fractions=TRUE) # reduced row-echelon form
```
