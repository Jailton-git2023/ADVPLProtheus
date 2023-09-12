#INCLUDE 'totvs.ch'
//static x:=10*12
User function vldCNPJ(cCodigo,cNome, cLoja,cCNPJ)
	//Local cCNPJ :="00000000000000"
	//Local cNome :=""
	//Local cLoja :=""
	Local nIdade
	Private cTitle :="ADVPL_TRN"

//MsgAlert(x)
//Validação do CPF/CNPJ
	IF CGC(cCNPJ) //.T.
		MsgInfo("CPF/CNPJ Validos")
		/* cNome   :="Jailton Lima"
		cLoja   :="01" */
		nIdade  := 44

		Dados(cCodigo,cNome, cLoja,cCNPJ)//Chama de função static
	ELSE
		MsgAlert("Dados Invalidos")
	ENDIF
RETURN

Static Function Dados(cCodigo,cNome, cLoja,cCNPJ)
//MsgInfo(cNome + cCNPJ + cLoja)
	If MsgYesNo("Os Dados do: " + chr(13) ;
			+ "CNPJ/CPF: " + cCNPJ + chr(13);
			+ "Nome: " + cNome + chr(13);
			+ "Loja: " + cLoja + chr(13);
			+ "Codigo: " + cCodigo + chr(13);
			+ "Foram recebidos com sucesso, Deseja realiza o cadastro no Protheus?",cTitle)
		Cadastro(cCodigo,cNome, cLoja,cCNPJ)

	else
		MsgAlert("Cancelado Pelo usuario", cTitle)
	EndIf
Return
//Cadastro 
Static Function Cadastro(cCodigo,cNome, cLoja,cCNPJ)
	Local cAlias :="SA1"
	//Local bInsert := .T.
	
	//Inclusão Aqui vi RECLOCK 
//Buscar Indices -  Pesquisa DBssek ou MsSeek
DbSelectArea(cAlias) // Abertura da area da tabela (edição)
DbSetOrder(1) // Indice na SIX - Filial + Codigo + Loja  (Chave Primaria)
If ! MsSeek(xFilial(cAlias) + cCodigo + cLoja) // .t.
		
		RecLock(cAlias, .T.) // Inclusão
		SA1->A1_FILIAL :=xFILIAL("SA1")
		SA1->A1_COD	:= cCodigo//GETSXENUM(cAlias,"A1_COD") // numeração incremental
		SA1->A1_CGC	:= cCNPJ
		SA1->A1_NOME := cNome
		SA1->A1_LOJA := cLoja
		SA1->A1_NREDUZ := SubStr(cNome, 1, 6) + "FANTA"
		SA1->A1_EST :="SP"
	MsUnlock() // Libera registro


ELSE
		RecLock(cAlias, .F.) // Update (Aletração) // Exclusão Update no campo D_E_L_E_T ='*'
		SA1->A1_CGC	:= cCNPJ
		SA1->A1_NOME := cNome
		SA1->A1_LOJA := cLoja
		SA1->A1_NREDUZ := SubStr(cNome, 1, 6) + "FANTA"
		SA1->A1_EST :="SP"
	MsUnlock()
ENDIF
	
/* 	MsgAlert("Os Dados do: " + chr(13) ;
			+ "CNPJ/CPF: " + cCNPJ + chr(13);
			+ "Nome: " + cNome + chr(13);
			+ "Loja: " + cLoja + chr(13);
			+ "Nome: " + cValToChar(nIdade) + chr(13);
			+ "foram cadastrados com sucesso",cTitle) */

			//
RETURN
