---
title: "R Notebook"
output: html_notebook
---

\newcommand{\R}{\mathbb{R}}
\newcommand{\E}{\mathcal{E}}
\newcommand{\B}{\mathcal{B}}
\DeclareMathOperator{\rank}{rango}
\DeclareMathOperator{\proj}{proj}
\DeclareMathOperator{\tr}{tr}

$$
\newcommand{\mathbb{R}}{\mathbb{R}}
\newcommand{\mathcal{E}}{\mathcal{E}}
\newcommand{\mathcal{B}}{\mathcal{B}}
\DeclareMathOperator{\mathop{\mathrm{rango}}}{rango}
\DeclareMathOperator{\mathop{\mathrm{proj}}}{proj}
\DeclareMathOperator{\mathop{\mathrm{tr}}}{tr}
$$

## Matrices especiales

### Matriz diagonal

Una matriz $A \in \mathbb{R}^{n \times n}$ se dice diagonal si $a_{ij} = 0$ para todo $i \neq j$, es decir:

$$
A =\begin{pmatrix}a_{11}&0&\cdots &0\\0&a_{22}&\cdots &0\\\vdots &\vdots &\ddots &\vdots \\0&0&\cdots &a_{nn}\\\end{pmatrix}
$$

**Ejercicios.** Calcular a mano pero sin hacer muchas cuentas:

-   $\begin{pmatrix}1&0&0 \\ 0&2&0 \\ 0& 0 & 3\end{pmatrix}^3$
-   $\begin{pmatrix}1&0&0 \\ 0&2&0 \\ 0& 0 & 3\end{pmatrix} \cdot \begin{pmatrix}1&1&1 \\ 2&2&2 \\ 3& 3 & 3\end{pmatrix}$
-   $\begin{pmatrix}1&1&1 \\ 2&2&2 \\ 3& 3 & 3\end{pmatrix} \cdot \begin{pmatrix}1&0&0 \\ 0&2&0 \\ 0& 0 & 3\end{pmatrix}$

En **R** usamos el comando `diag` para definir matrices diagonales. También existe un paquete Matrix que permite trabajar con matrices más eficientemente en términos de memoria y uso de CPU.

```{r}
D = diag(c(1,2,3))
print(D)

print(D %*% D)
```

### Matriz identidad

Para cada $n \in \mathbb{N}$, la matriz $I_n \in \mathbb{R}^{n \times n}$ es la matriz diagonal con $I_{ii} = 1$ para todo $i$, es decir:

$$
I_n =\begin{pmatrix}1&0&\cdots &0\\0&1&\cdots &0\\\vdots &\vdots &\ddots &\vdots \\0&0&\cdots &1\\\end{pmatrix}
$$

**Propiedad:**

-   Para toda $B \in \mathbb{R}^{n \times n}$ , $I_n \cdot B = B \cdot I_n = B$.

En **R** podemos usar el mismo comando `diag` para definir una matriz identidad.

```{r}
I = diag(5)
print(I)

A = matrix(runif(5*5), 5, 5)   # Matriz con números aleatorios entre 0 y 1
print(A)
print(I %*% A)
```

**Matriz triangular superior e inferior**

-   Una matriz $U \in \mathbb{R}^{n \times n}$ se llama triangular superior si $a_{ij} = 0$ para todo $i > j$ (es decir, todas las entradas abajo de la diagonal son 0).

-   Una matriz $L \in \mathbb{R}^{n \times n}$ se llama triangular inferior si $a_{ij} = 0$ para todo $i > j$ (es decir, para todas las entradas arriba de la diagonal son 0).

**Matriz simétrica:** $A$ es simétrica si $A^T = A$.

**Matriz ortogonal:** $A$ es ortogonal si $AA^T = A^TA = I_n$.

## Inversa de una matriz

Dada una matriz $A \in \mathbb{R}^{n \times n}$, si existe una matriz $B \in \mathbb{R}^{n\times n}$ tal que

$$
AB = I_n = BA,
$$

decimos que $A$ es inversible y $B$ es la inversa de $A$. Si $A$ es inversible, la inversa es única y la notamos $A^{-1}$. Si $A$ no es inversible, decimos que $A$ es singular.

**Aplicación:** Si $A \in \mathbb{R}^{n \times n}$ es inversible, la solución del sistema

$$
Ax = b
$$

es $x = A^{-1}b$.

Para calcular la inversa en **R** usamos `solve` (podemos pensar que resolvemos la ecuación matricial $A \cdot X = I_n$ ).

```{r}
A = matrix(c(1, 7, 2, 3), nrow=2)
A_inv = solve(A)  
print(A)
print(A_inv)

print(A_inv %*% A)

```

**Nota:** En la práctica, ¡es mejor resolver un sistema por eliminación gaussiana que invirtiendo la matriz!

### Traza de una matriz

La traza de una matriz **cuadrada** es la suma de los elementos de la diagonal.

Si $A = (a_{ij}) \in \mathbb{R}^{n \times n}$, $\mathop{\mathrm{tr}}(A) = a_{11} + a_{22} + \dots + a_{nn} = \sum_{i=1}^n a_{ii}$ .

**Propiedades.** Si $A, B \in \mathbb{R}^{n \times n}$:

-   $\mathop{\mathrm{tr}}(A^T)=\mathop{\mathrm{tr}}(A)$

-   $\mathop{\mathrm{tr}}(A+B) = \mathop{\mathrm{tr}}(A) + \mathop{\mathrm{tr}}(B)$.

```{r}
A = matrix(c(1,5,1,-6, 7, 8, 0, 9, -2), nrow=3)
print(A)
tr(A)
```

### Determinante de una matriz

El determinante de una matriz **cuadrada** se puede definir recursivamente por la siguiente fórmula

$$
\det(A)= \begin{cases}
a_{11} & \text{si } n = 1 \\
\sum _{j=1}^{n}(-1)^{i+j}a_{ij}M_{ij} \quad \text{ para cualquier $i$ fijo}& \text{si } n > 1,
\end{cases}
$$

donde $M_{ij}$ es el determinante de la matrix de $(n-1) \times (n-1)$ que se obtiene al eliminar la fila $i$ y la columna $j$ de $A$.

**Ejemplos**

-   $\det\begin{pmatrix} a & b \\ c & d \end{pmatrix} = ad - bc$

-   $\det\begin{pmatrix} 1 & 2 & 3 \\ 3 & 0 & 7 \\ 0 & -1 & 4 \end{pmatrix} = \det\begin{pmatrix} 0 & 7 \\ -1 & 4 \end{pmatrix} - 3 \det\begin{pmatrix} 2 & 3 \\ -1 & 4 \end{pmatrix} = 7 - 3 \cdot 11=-26$

En el último ejemplo decimos que calculamos el determinante desarrollando la primer columna.

### Propiedades

-   $\det(AB) = \det(A)\det(B)$

-   $\det(A^T) = \det(A)$

-   $\det\begin{pmatrix} f_1 \\ \vdots \\ f_{i-1} \\ \alpha f_i + \beta f_j \\ f_{i+1} \\ \vdots \\ f_n \end{pmatrix} = \alpha \det(A)$

-   $\det\begin{pmatrix} f_1 \\ \vdots \\ f_{i} \\ \vdots \\ f_{j} \\ \vdots \\ f_n \end{pmatrix} = - \det\begin{pmatrix} f_1 \\ \vdots \\ f_{j} \\ \vdots \\ f_{i} \\ \vdots \\ f_n \end{pmatrix}$

-   $\det(kA)=k^n \det(A), k \in \mathbb{R}$

-   $\det(-A)=(-1)^n \det(A)$

-   $\det(A) = 0$ si y solo si $A$ es singular.

Calculamos algunos determinantes en **R**.

```{r}
M = matrix(c(1,2,3,3,0,7,0,-1,4),nrow=3)
print(M)
A = matrix(c(1,5,0,-1, -3, 8, 0, 1, -2), nrow=3)
print(A)
B = matrix(c(0,4,2, 2, 6,1,1, 5, -1), nrow=3)
print(B)

det(M)
det(A)
det(B)
det(A %*% B)
det(A + B)  # No hay relación con los determinantes de A y B
```

¿Qué determinante tiene la siguiente matriz?

```{r}
A = matrix(c(1,2,3,4,5,6,7,8,9), nrow = 3)
det(A)

```

### Determinante de una matriz triangular superior o inferior

$$
\det\begin{pmatrix}a_{11}&a_{12}&\cdots & a_{1n} \\ 0 &a_{22}&\cdots & a_{2n}\\\vdots &\vdots &\ddots &\vdots \\0&0 & \cdots &a_{nn}\\\end{pmatrix} = \det\begin{pmatrix}a_{11}& 0&\cdots &0 \\ a_{21} &a_{22}&\cdots & 0\\\vdots &\vdots &\ddots &\vdots \\a_{n1}&a_{n2} & \cdots &a_{nn}\\\end{pmatrix} = \prod_{i=1}^n a_{ii}
$$

**Ejercicio.** Para $A = \begin{pmatrix} 3 & 2 & -1 \\ 3 & 0 & 7 \\ 0 & -1 & 4 \end{pmatrix}$ , probar que el sistema $Ax = b$ tiene solución única para todo $b \in \mathbb{R}^3$
