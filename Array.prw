#INCLUDE 'totvs.ch'
User Function aTest3()
	Local cNome
	Local aRegistros, aReg, aReg2
	Local aCores, aCor
	Local x,y
	aRegistros := {{"Nome","Loja","cnpj","Codigo"} ,;
		{"cNome","cLoja","cCNPJ","cCodigo"};
		}
	aReg    := aRegistros[1]
	aReg2   := aRegistros[2]
//MsgAlert(aReg[1])

	for x := 1 to len(aReg)
        MsgInfo(aReg[x])
		for y:= 1 to len(aReg2)
	       Msgalert(aReg2[y])
		next
    	
	NEXT

/* aCores := { {0,"Preto"}, {1,"Azul"} , {2,"Verde"} }
aCor := aCores[1]
conout(aCor[1]) // deve mostrar 0 (zero)
conout(aCor[2]) // deve mostrar "Preto"
TrocaCor(aCor,"VERMELHO")
conout(aCores[1][2]) // deve mostrar VERMELHO  */
Return

Static function TrocaCor(aArr,cVal)
aArr[2] := cVal
Return
