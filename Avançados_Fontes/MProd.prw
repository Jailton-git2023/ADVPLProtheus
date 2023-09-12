#include 'protheus.ch'
#include 'parmtype.ch'

user function MProd()

Local oReport

	//Criando o grupo de pergunta
	//CriaPerg()
	
	//Carregando os dados da pergunta
 Pergunte("ZMPROD",.F.)
 	
	//Chando a Função para criar a estrutura do relatorio	
	oReport := ReportDef()
  
  //Imprimindo o Relatorio
	oReport:PrintDialog()
      

Return( Nil )


Static Function ReportDef()

Local oReport
Local oSection
Local oBreak

// Criando a o Objeto

oReport := TReport():New("Produtos personalizados","Meus Produtos","ZMPROD",{|oReport| PrintReport(oReport)},"Novos produtos")

oSection := TRSection():New(oReport,"Meus produtos",{"SZ2"} ) //Seção de um relatório que utiliza a classe TReport

	
	TRCell():New(oSection,"Z2_COD"    ," SZ2","Produtos")
	TRCell():New(oSection,"Z2_NOME"   , "SZ2")
	TRCell():New(oSection,"Z2_LIST"   , "SZ2")
	TRCell():New(oSection,"Z2_PRVD"    , "SZ2")
	

// Quebra por Vendedor
oBreak := TRBreak():New(oSection,oSection:Cell("Z2_LIST"),;
"Sub Total lista")     

//Fazendo a contagem por codigo
 TRFunction():New(oSection:Cell("Z2_COD"   ), NIL, "COUNT", oBreak)


Return ( oReport )



Static Function PrintReport(oReport)

Local oSection := oReport:Section(1)
Local cPart := ""

oSection:BeginQuery()

	cPart := "% AND Z2_COD >= '" + MV_PAR01 + "' "
	cPart += "  AND Z2_COD <= '" + MV_PAR02 + "' %"
  
BeginSql alias "QRYSZ2"

	SELECT 
           Z2_COD,
     Z2_NOME,
     Z2_LIST,
     Z2_PRVD
     
	FROM %table:SZ2% SZ2
	WHERE Z2_FILIAL = %xfilial:SZ2% 
	//AND Z2_MSBLQL <> '1' 
	AND SZ2.%notDel% 
	%exp:cPart%
	ORDER BY Z2_COD Desc
EndSql

aRetSql := GetLastQuery()
oSection:EndQuery()
oSection:Print()

Return( Nil )


/*

Static Function CriaPerg()

Local _sAlias 	:= Alias()
Local aArea   	:= GetArea()
Local aRegs   	:= {}
Local nI		:= 0
Local nJ		:= 0
Local nCampo	:= 0
Local nX		:= 0

Local cPerg		:= "XCLIVEND"

dbSelectArea("SX1")
dbSetOrder(1)

cPerg := PADR(cPerg,10) 

// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
aCampos := {"GRUPO","ORDEM","PERGUNT","VARIAVL","TIPO","TAMANHO","DECIMAL","PRESEL","GSC","VALID","VAR01","DEF01","CNT01","VAR01","DEF01","CNT01","VAR02","DEF02","CNT02","VAR03","DEF03","CNT03","VAR04","DEF04","CNT04","VAR05","DEF05","CNT05","F3"}

aAdd(aRegs,{cPerg,"01","Cliente de			","","","mv_ch1" ,"C",TamSX3("A1_COD")[1]	,0,0,"G",""	,"MV_PAR01","","","","","","","","","","","","","","","SA1"})
aAdd(aRegs,{cPerg,"02","Cliente ate		  	","","","mv_ch2" ,"C",TamSX3("A1_COD")[1]	,0,0,"G",""	,"MV_PAR02","","","","","","","","","","","","","","","SA1"})

dbSelectArea("SX1")
dbSetOrder(1)
For nX:=1 to Len(aRegs)
	If	DbSeek( cPerg + aRegs[nx][02] )   
    	If	RecLock('SX1',.F.)
			Replace SX1->X1_GRUPO  		With aRegs[nx][01]
			Replace SX1->X1_ORDEM   	With aRegs[nx][02]
			Replace SX1->X1_PERGUNTE	With aRegs[nx][03]
			Replace SX1->X1_PERSPA		With aRegs[nx][04]
			Replace SX1->X1_PERENG		With aRegs[nx][05]
			Replace SX1->X1_VARIAVL		With aRegs[nx][06]
			Replace SX1->X1_TIPO		With aRegs[nx][07]
			Replace SX1->X1_TAMANHO		With aRegs[nx][08]
			Replace SX1->X1_DECIMAL		With aRegs[nx][09]
			Replace SX1->X1_PRESEL		With aRegs[nx][10]
			Replace SX1->X1_GSC		  	With aRegs[nx][11]
			Replace SX1->X1_VALID		With aRegs[nx][12]
			Replace SX1->X1_VAR01		With aRegs[nx][13]
			Replace SX1->X1_DEF01	  	With aRegs[nx][14]
			Replace SX1->X1_DEF02		With aRegs[nx][17]
			Replace SX1->X1_DEF03		With aRegs[nx][20]
			Replace SX1->X1_DEF04		With aRegs[nx][23]
			Replace SX1->X1_DEF05		With aRegs[nx][26]
			Replace SX1->X1_F3   		With aRegs[nx][28]
			SX1->(MsUnlock())
		Else
			Help('',1,'REGNOIS')
		EndIf	
	Else
		If	RecLock('SX1',.T.)
			Replace SX1->X1_GRUPO  		With aRegs[nx][01]
			Replace SX1->X1_ORDEM   	With aRegs[nx][02]
			Replace SX1->X1_PERGUNTE	With aRegs[nx][03]
			Replace SX1->X1_PERSPA		With aRegs[nx][04]
			Replace SX1->X1_PERENG		With aRegs[nx][05]
			Replace SX1->X1_VARIAVL		With aRegs[nx][06]
			Replace SX1->X1_TIPO		With aRegs[nx][07]
			Replace SX1->X1_TAMANHO		With aRegs[nx][08]
			Replace SX1->X1_DECIMAL		With aRegs[nx][09]
			Replace SX1->X1_PRESEL		With aRegs[nx][10]
			Replace SX1->X1_GSC		  	With aRegs[nx][11]
			Replace SX1->X1_VALID		With aRegs[nx][12]
			Replace SX1->X1_VAR01		With aRegs[nx][13]
			Replace SX1->X1_DEF01	  	With aRegs[nx][14]
			Replace SX1->X1_DEF02		With aRegs[nx][17]
			Replace SX1->X1_DEF03		With aRegs[nx][20]
			Replace SX1->X1_DEF04		With aRegs[nx][23]
			Replace SX1->X1_DEF05		With aRegs[nx][26]
			Replace SX1->X1_F3   		With aRegs[nx][28]
			SX1->(MsUnlock())
		Else
			Help('',1,'REGNOIS')
		EndIf	
	Endif
Next nX


dbSelectArea(_sAlias)

RestArea(aArea)

Return NIL
*/

//return