include("../src/Pas_De_Cauchy.jl")


"#test de l'algorithme de pas de cauchy :
 #on test : la saturation/non satiration de la boule et la nullité du gradient"

"""
   #Entrées :
	#affichage : boolean , si true on affiche les sorties de chaque test
   #Sorties :
	#nbtest_reu : nombre de tests réussis
	#nbtest_total : nombre de tests total effectués
"""

function test_pas_de_cauchy(affichage)

nbtest_reu = 0
nbtest_total = 0


"# Pour la quadratique 1"
g1 = [0; 0]
H1 = [7 0 ; 0 2]
delta1 = 1
s1, e1 = Pas_De_Cauchy(g1,H1,delta1)
#@test e1 == 0
if (e1==0)
	nbtest_reu = nbtest_reu + 1
end
#printstyled("=",bold=true,color=:white)
nbtest_total = nbtest_total + 1


"# Pour la quadratique 2"
g2 = [6; 2]
H2 = [7 0 ; 0 2]
delta2 =3
s2, e2 = Pas_De_Cauchy(g2,H2,delta2)
#@test e2 ==1
if (e2==1)
	nbtest_reu = nbtest_reu + 1
end
#printstyled("=",bold=true,color=:white)
nbtest_total = nbtest_total + 1


"# Pour la quadratique 3"
g3 = [-2; 1]
H3 = [-2 0 ; 0 10]
delta3 = 10
s3, e3 = Pas_De_Cauchy(g3,H3,delta3)
#@test e3 == (norm(g3)!=0)
if (e3==1)
	nbtest_reu = nbtest_reu + 1
end
#printstyled("=> ",bold=true,color=:white)
nbtest_total = nbtest_total + 1

#printstyled(" Tous les tests sont réussis ! \n",bold=true,color=:green)
res = @testset "cauchy" begin 
           @test e1 == 0
           @test e2 == 1
           @test e3 == 1
end
println("\n")

return 

end
