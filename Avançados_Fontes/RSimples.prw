#Include "Protheus.ch"

User Function RMP()
Local oReport := nil


oReport := RptDef()//Chama a função para carregar a Classe tReport
oReport:PrintDialog()

Return()


Static Function RptDef()

Local oReport := Nil
Local oSection1:= Nil
Local oBreak
Local oFunction
 	
//Sintaxe: 
//Classe TReport
//cNome: Nome físico do relatório
//cTitulo: Titulo do Relario
//cPergunta: Nome do grupo de pergunta que sera carredo em parâmetros
//bBlocoCodigo: Execura a função que ira alimenter as TRSection
//TReport():New(cNome,cTitulo,cPerguntas,bBlocoCodigo,cDescricao)

oReport:=TReport():New("Carlitos", "Meus produtos",/* cPergunta */,;
 {|oReport| ReportPrint( oReport ) }, "Meus produtos")

// Relatorio em retrato 
oReport:SetPortrait() //Define orientação de página do relatório como retrato

// Define se os totalizadores serão impressos em linha ou coluna
oReport:SetTotalInLine(.F.) //Define se os totalizadores serão impressos em linha ou coluna.
	
//Monstando a primeira seção
oSection1:= TRSection():New(oReport, "Produtos", {"SZ2"}, NIL, .F., .T.) // A classe TRSection pode ser entendida como um layout do relatório, por conter células, quebras e totalizadores que darão um formato para sua impressão.
TRCell():New(oSection1, "Z2_COD"    ,"SZ2","Produto"		,"@!",30 )
TRCell():New(oSection1, "Z2_NOME"   ,"SZ2","Nome"	,"@!",100)
TRCell():New(oSection1, "Z2_LIST" ,"SZ2","Lista"	,"@!",20 )
TRCell():New(oSection1, "Z2_PRVD" ,"SZ2","PRECO"			,"@!",12 )


//O parâmetro que indica qual célula o totalizador se refere ,
//será utilizado para posicionamento de impressão do totalizador quando 
//estiver definido que a impressão será por coluna e como conteúdo para a 
//função definida caso não seja informada uma fórmula para o totalizador
TRFunction():New(oSection1:Cell("Z2_COD"),NIL,"COUNT",,,,,.F.,.T.)

Return(oReport)



Static Function ReportPrint(oReport)

Local oSection1 := oReport:Section(1)
Local cQuery    := ""
Local cNcm      := ""
Local lPrim 	:= .T.
Local cAlias  := GetNextAlias()
cPart := "% AND Z2_COD >= '' "
cPart += "  AND Z2_COD <= 'ZZZZZZZZZZ' %"

BeginSql alias cAlias

	SELECT Z2_COD,Z2_NOME,Z2_LIST,Z2_PRVD
	FROM %table:SZ2% SZ2
	WHERE Z2_FILIAL = %xfilial:SZ2%
	AND Z2_MSBLQL <> '1'
	AND SZ2.%notDel%
	
	%exp:cPart%
	
	ORDER BY Z2_COD
	
EndSql
		
dbSelectArea(cAlias)
(cAlias)->(dbGoTop())
	
oReport:SetMeter((cAlias)->(LastRec()))

While !(cAlias)->( EOF() )
		
	If oReport:Cancel()
		Exit
	EndIf
	
	oReport:IncMeter() //Incrementa a régua da tela de processamento do relatório
			
	IncProc("Imprimindo " + alltrim((cAlias)->Z2_NOME))
		
	//inicializo a primeira seção
	oSection1:Init()
	
	//imprimo a seção, relacionando os campos da section com os 
           //valores da tabela
		
	oSection1:Cell("Z2_COD"   ):SetValue((cAlias)->Z2_COD    )
	oSection1:Cell("Z2_NOME"  ):SetValue((cAlias)->Z2_NOME   )
	oSection1:Cell("Z2_LIST"):SetValue((cAlias)->Z2_LIST )
	oSection1:Cell("Z2_PRVD"):SetValue((cAlias)->Z2_PRVD)
	oSection1:Printline()

	(cAlias)->(dbSkip())
 			
		//imprimo uma linha 
	oReport:ThinLine()
		
EndDo
	
//finalizo seção
oSection1:Finish()
	
Return( NIL )


