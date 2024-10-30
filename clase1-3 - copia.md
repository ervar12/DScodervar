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

## Operaciones con vectores y matrices

### Operaciones de espacio vectorial

Las operaciones de espacio vectorial son:

-   Suma de vectores o matrices del mismo tamaño.

-   Producto de vectores o matrices por un *escalar* (un número del cuerpo $\mathbb{R}$).

```{r}
v1 = c(10, 5, -7, 1)
v2 = c(5, 0, 7, 2)
print(v1 + v2)


A1 = matrix(c(1,2,3,4), nrow = 2)
A2 = matrix(c(2,7,1,0), nrow = 2)
A3 = matrix(c(2,7,1,0), nrow = 1)

print("A1")
print(A1)
print(A2)
print(A3)
print(A1 + A2)  # Matriz de 2 x 2
#print(A1 + A3)  # No podemos sumar matrices de distinto tamaño
```

Para sumar vectores con matrices de la misma dimensión total, **R** interpreta al vector como matriz del mismo tamaño.

```{r}

# A3 es una matrix de 1 x 4
print(A3 + v2)

# A4 es una matrix de 4 x 1
A4 = matrix(c(2,7,1,0), ncol = 1)
print(A4 + v2)   

# A1 es una matrix de 2 x 2
print(A1 + v2)

```

### Multiplicación de matrices

Si multiplicamos dos matrices o vectores en **R** con `*` obtenemos el producto *punto a punto*.

```{r}
A1 = matrix(c(1,2,3,4), nrow = 2)
A2 = matrix(c(1,0, 0, 1), nrow = 2)
print(A1)
print(A2)
print(A1 * A2)
```

La operación `*` en **R** calcula el producto coordenada a coordenada. Esta operación se llama producto de Hadamard, y es útil en muchos casos, pero no es el producto usual de matrices.

Para el producto usual de matrices usamos en **R** la operación `%*%`!

```{r}
print(A1 %*% A2)  # Producto usual de matrices
```

Dadas matrices $A \in \mathbb{R}^{m \times n}$ y $B \in \mathbb{R}^{n \times p}$

$$
A =\begin{pmatrix}a_{11}&a_{12}&\cdots &a_{1n}\\a_{21}&a_{22}&\cdots &a_{2n}\\\vdots &\vdots &\ddots &\vdots \\a_{m1}&a_{m2}&\cdots &a_{mn}\\\end{pmatrix},\quad  {B} ={\begin{pmatrix}b_{11}&b_{12}&\cdots &b_{1p}\\b_{21}&b_{22}&\cdots &b_{2p}\\\vdots &\vdots &\ddots &\vdots \\b_{n1}&b_{n2}&\cdots &b_{np}\\\end{pmatrix}}
$$ el producto $C = AB$ es la matriz de $m$ filas y $p$ columnas

$$
C =\begin{pmatrix}c_{11}&c_{12}&\cdots &c_{1p}\\c_{21}&c_{22}&\cdots &c_{2p}\\\vdots &\vdots &\ddots &\vdots \\c_{m1}&c_{m2}&\cdots &c_{mp}\\\end{pmatrix} \in \mathbb{R}^{m \times p}.
$$

con $c_{ij}=a_{i1}b_{1j}+a_{i2}b_{2j}+\cdots +a_{in}b_{nj}=\sum _{k=1}^{n}a_{ik}b_{kj}$ (en la casilla $(i,j)$ de $C$ ponemos el producto de la fila $i$ de $A$ con la columna $j$ de $B$) .

¡Revisar siempre que estemos usando el producto correcto en **R**!

#### Ejercicio

Realizar (a mano) los siguientes productos de matrices:

1.  $\begin{pmatrix}3&5\\ 2 & -9 \end{pmatrix} \cdot \begin{pmatrix}1&-1\\ 0 & 2 \end{pmatrix}$

2.  $\begin{pmatrix}3&5\end{pmatrix} \cdot \begin{pmatrix}4\\ -3\end{pmatrix}$

3.  $\begin{pmatrix}4\\ -3\end{pmatrix} \cdot \begin{pmatrix}3&5\end{pmatrix}$

4.  $\begin{pmatrix}3&5&0\\ 2 & -9 & 7 \end{pmatrix} \cdot \begin{pmatrix}x\\ y \\z \end{pmatrix}$

### Matriz transpuesta

La matriz transpuesta de $A = (a_{ij}) \in {\mathbb{R}^{m \times n}}$ es $A^T = (a_{ji}) \in \mathbb{R}^{n \times m}$.

#### Ejemplos

-   Si $A =\begin{pmatrix}a_{11}&a_{12}&a_{13} \\ a_{21}&a_{22}&a_{23}\end{pmatrix}$ , $A^T = \begin{pmatrix}a_{11}&a_{21}\\a_{12} & a_{22} \\ a_{13} & a_{23}\end{pmatrix}$.

-   Si $A =\begin{pmatrix}5&7 \\ 3&-1\end{pmatrix}$ , $A^T = \begin{pmatrix}5&3\\7 & -1 \end{pmatrix}$.

```{r}
A = matrix(c(5,7,3,-1), ncol = 2, byrow = TRUE)
print(A)
t(A)
```

## Sistemas lineales y ecuaciones matriciales

Observando el producto punto 4 del último ejercicio, vemos que el sistema de ecuaciones lineales

$$
\left\{ {\begin{alignedat}{5}
3x&&\;+\;&&5y&&\;\;&&&&\;=\;&&4&\\
2x&&\;-\;&&9y&&\;+\;&&7z&&\;=\;&&15&.
\end{alignedat}} \right.
$$

podemos plantearlo en forma matricial:

$$\begin{pmatrix}3&5&0\\ 2 & -9 &7\end{pmatrix} \cdot \begin{pmatrix}x\\ y \\z\end{pmatrix} = \begin{pmatrix}4\\ 15 \end{pmatrix}$$

o en general, $A x = b$, donde $A \in \mathbb{R}^{m \times n}$ es la matriz de coeficientes, $x$ es un vector o matriz columna de incógnitas y $b \in \mathbb{R}^{n}$ es el vector de términos constantes.

**Pregunta:** ¿cuántas incógnitas y cuántas ecuaciones tiene el sistema $Ax=b$ con los tamaños dados?

Para resolver sistemas de ecuaciones en **R** con igual número de ecuaciones e incógnitas (la matriz $A$ es cuadrada) podemos usar el comando `solve`.

Resolvemos:$$
\left\{ {\begin{alignedat}{5}
3x&&\;+\;&&5y\;=\;&&4&\\
2x&&\;-\;&&9y\;=\;&&15&.
\end{alignedat}} \right.
$$

```{r}
A = matrix(c(3, 5, 2, -9), nrow = 2, byrow = TRUE)
b = c(4, 15)
solve(A, b)
```

Cuando no hay solución única, podemos triangular la matriz y obtener a partir de ahí las soluciones, veremos esto más adelante.
