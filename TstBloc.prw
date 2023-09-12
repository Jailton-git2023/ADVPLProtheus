#include 'protheus.ch'
#include 'parmtype.ch'

user function TstBloc()

Local bBloco:={||2*10}

Local nResult

nResult:=Eval(bBloco)

Alert(nResult)

	
return()

//----------------------------

User Function TstB2()

Local x, y, z

Local bBloco:={|| x:=10,y:=111, z:=1000}

MsgAlert(Eval(bBloco))

Return()


 