#INCLUDE 'totvs.ch'

user Function Barra()

Local nTotal as Numeric
Local _ni as Numeric
//Local nTipo as Numeric
//default lLoop := .T.
nTotal := 30
ProcRegua(nTotal) //seta o total de registros
For _ni := 1 to nTotal
    MsProcTxt("Analisando registro " + cValToChar(_ni) + " de " + cValToChar(nTotal) + ", aguarde.")
    PROCESSMESSAGES()
    Sleep( 500 ) // Para o processamento por 1/2 segundo
Next
    oProcess := MsNewProcess():New({|| U_TDRFW4(oProcess)}, "Processando...", "Aguarde...", .T.)
    oProcess:Activate()
   
Return .t.
