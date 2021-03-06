@doc doc"""
Approximation de la solution du problème ``\min_{x \in \mathbb{R}^{n}} f(x)`` en utilisant l'algorithme de Newton

# Syntaxe
```julia
xk,f_min,flag,nb_iters = Algorithme_de_Newton(f,gradf,hessf,x0,option)
```

# Entrées :
    * **f**       : la fonction à minimiser
    * **gradf**   : le gradient de la fonction f
    * **hessf**   : la Hessienne de la fonction f
    * **x0**      : première approximation de la solution cherchée
    * **options** :
        * **eps**      : pour fixer les conditions d'arrêt
        * **max_iter** : le nombre maximal d'iterations
        * **tol**      : pour les condition d'arrêts

# Sorties:
    * **x_min**    : une approximation de la solution du problème  : ``\min_{x \in \mathbb{R}^{n}} f(x)``
    * **fx_min**   : ``f(x_{min})``
    * **flag**     : entier indiquant le critère sur lequel le programme à arrêter
	* **0**    : Convergence
	* **1**    : stagnation du xk
	* **2**    : stagnation du f
	* **3**    : nombre maximal d'itération dépassé
    * **nb_iters** : le nombre d'itérations faites par le programme

# Exemple d'appel
```julia
f(x)=100*(x[2]-x[1]^2)^2+(1-x[1])^2
gradf(x)=[-400*x[1]*(x[2]-x[1]^2)-2*(1-x[1]) ; 200*(x[2]-x[1]^2)]
hessf(x)=[-400*(x[2]-3*x[1]^2)+2  -400*x[1];-400*x[1]  200]
x0 = [1; 0]
options = []
xk,fx_min,flag,nb_iters = Algorithme_de_Newton(f,gradf,hessf,x0,options)
```
"""

function Algorithme_De_Newton(f::Function,gradf::Function,hessf::Function,x0,options)

        "# Si option est vide on initialise les 3 paramètres par défaut"
        if options == []
                eps = 1e-8
                max_iter = 100
                tol = 1e-15
        else
                eps = options[1]
                max_iter = options[2]
                tol = options[3]

        end

        xk = x0
        flag = 0
        nb_iters = 1
        gradZero = gradf(x0)
        dk = hessf(x0)\(-gradf(x0))
        xk1 = xk + dk

        while true
                xk = xk1
                "#direction de Newton"
                dk = hessf(xk)\(-gradf(xk))
                "# mise à jour du xk"
                xk1 = xk + dk
                "# le gradient du xk courant"
                grad = gradf(xk)
                "
                #####
                #                       Tests d'arrêt                     #
                #####
                "
                "# la CN1"
                if norm(grad)<(tol*norm(gradZero) +eps)
                        flag = 0
                        break

                "# la stagnation du xk"
                elseif norm(dk) < (tol*norm(xk) + eps)
                        flag = 1
                        break

                "# la stagnation du f"
                elseif abs(f(xk1)-f(xk))< (tol*abs(f(xk)) + eps)
                        flag = 2
                        break

                "# le nombre d'itérations dépasse le max"
                elseif nb_iters > max_iter
                        flag = 3
                        break
                end

                nb_iters = nb_iters +1
        end

        fx_min = f(xk)
        return xk,fx_min,flag,nb_iters
end
