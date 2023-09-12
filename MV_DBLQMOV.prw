#INCLUDE 'totvs.ch'

user Function AlteraBLQDT()

 //Barra de Progresso
 	Processa({|| U_TDRFW2()}, "Alterar Parametro...")
	U_DBLQMOV()
RETURN
//PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" USER "Administrador" PASSWORD "" TABLES "SA1,SB1" MODULO "ESP"
	/* oProcess := MsNewProcess():New({|| U_TDRFW4(oProcess)}, "Processando...", "Aguarde...", .T.)
    oProcess:Activate() */

User Function DBLQMOV()
	Local oDlg
	LOCAL dDBLQ := GETMV("MV_DBLQMOV")
	Local dAtual := GETMV("MV_DBLQMOV") 
	Private dUlMes := GETMV("MV_ULMES")	// CriaVar("SX6-X6_VAR")
	Private dNovo
// Tela Alteração Parametro
	DEFINE MSDIALOG oDlg TITLE "Altera Parametros" FROM 000,000 TO 125,300 PIXEL
	@ 010,010 SAY "Conteudo Atual:" SIZE 55,07 OF oDlg PIXEL
	@ 010,050 MSGET dDBLQ SIZE 40,11 OF oDlg PIXEL When .F.
	//PICTURE "@!" ;
//VALID 
	@ 030,010 SAY "Novo Conteudo:" SIZE 55,07 OF oDlg PIXEL
	@ 025,050 MSGET dAtual SIZE 40,11 OF oDlg PIXEL //PICTURE "@!";

	@ 050,010 SAY "Ult.Fechamento:" SIZE 55,07 OF oDlg PIXEL
	@ 045,050 MSGET dUlMes SIZE 40,11 OF oDlg PIXEL When .F.

	DEFINE SBUTTON FROM 010, 100 TYPE 1 ACTION (vldCampos(dAtual), oDlg:End()) ENABLE OF oDlg
	DEFINE SBUTTON FROM 025, 100 TYPE 2 ACTION (Alert("Encerrado!"), oDlg:End()) ENABLE OF oDlg

	ACTIVATE MSDIALOG oDlg CENTERED

//RESET ENVIRONMENT

RETURN

/*
Exemplo de uso de MSAGUARDE
*/
Static function vldCampos(dAtual)
	//Local Mes   :=GetMV("MV_ULMES")

	If dAtual >= dUlMes

		dNovo:=PUTMV("MV_DBLQMOV",dAtual)
		If dNovo // .T.
			dNovo:= GetMV("MV_DBLQMOV")
			MsgInfo(dToC(dNovo))
		else
			MsgAlert("Algo deu errado")
			RETURN U_AlteraBLQDT()
		ENDIF
	//Barra opcional no final do Processamento
	//MsAguarde({|| U_TDRFW3()}, "Aguarde...", "Processando Registros...")
	else
		Alert("Não foi possível atualizar! Data Menor que a do Ultimo Fechamento MV_ULMES=" + dToc(dUlMes))
		RETURN U_DBLQMOV()
	EndIf
//voltei...
RETURN
