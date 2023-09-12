#INCLUDE'totvs.ch
user function tela()

	Local oDlg
	Local cCNPJ     := CriaVar("SA1->A1_CGC") // Tama no SX3 - X3_TAM
	Local cNome     := CriaVar("SA1->A1_NOME")
	Local cLoja     := CriaVar("SA1->A1_LOJA")
	Local cCodigo   := CriaVar("SA1->A1_COD")
	//Local aDados	:= {cCNPJ,cNome,cLoja,cCodigo}
//Elementos Visuais

/* 
Say;
MSGet; 
Sbutton; */
//DbSelectArea("SA1")
DEFINE MSDIALOG oDlg TITLE "Tela Cadastro" FROM 000,000 TO 220,420 PIXEL
@ 010,010 SAY "Codigo:" SIZE 55,07 OF oDlg PIXEL
@ 010,050 MSGET cCodigo F3 "SA1" SIZE 40,11 OF oDlg PIXEL PICTURE "@!" ;
VALID VldExiste(cCodigo,cLoja)

@ 030,010 SAY "Loja:" SIZE 55,07 OF oDlg PIXEL
@ 025,050 MSGET cLoja SIZE 20,11 OF oDlg PIXEL PICTURE "@!"

@ 050,010 SAY "Nome Cliente:" SIZE 55,07 OF oDlg PIXEL
@ 045,050 MSGET cNome SIZE 130,11 OF oDlg PIXEL PICTURE "@!"

@ 070,010 SAY "CNPJ:" SIZE 55,07 OF oDlg PIXEL
@ 065,050 MSGET cCNPJ SIZE 65,11 OF oDlg PIXEL PICTURE "@R 99.999.999/9999-99"

DEFINE SBUTTON FROM 070, 120 TYPE 1 ACTION (vldCampos(cCodigo,cNome, cLoja,cCNPJ), oDlg:End()) ENABLE OF oDlg
DEFINE SBUTTON FROM 070, 170 TYPE 2 ACTION (Alert("Encerrado!"), oDlg:End()) ENABLE OF oDlg

ACTIVATE MSDIALOG oDlg CENTERED

RETURN

//VALIDA«’ES DE CAMPOS VAZIOS

Static Function VldExiste(cCodigo,cLoja)
Local cAlias:="SA1"
* Validar se campo codigo, ent√£o carregar os demais dados na tela, caso contrario
DbSelectArea(cAlias)
DbSetOrder(1)
If MsSeek(xfilial(cAlias) + cCodigo)
//RecLock(cAlias, .F.)
cLoja := SA1->A1_LOJA
cNome := SA1->A1_NOME
cCNPJ  := SA1->A1_CGC   
//MsUnlock()

EndIf
Return

static Function vldCampos(cCodigo,cNome, cLoja,cCNPJ)
If ! Empty(cCodigo) .and. ! Empty(cNome)  .and. ! Empty(cLoja) .and. !Empty(cCNPJ) // .or ou
    U_vldCNPJ(cCodigo,cNome, cLoja,cCNPJ)       
else
    MsgAlert("Todos os Campos s√£o Obrigatorios")
    RETURN u_tela() // Chamada da Tela 
Endif
RETURN
