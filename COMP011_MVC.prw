//Bibliotecas 
#Include 'Protheus.ch'
#Include 'FWMVCDef.ch'
 
//Vari�veis Est�ticas
Static cTitulo := "Grp.Produtos (Mod.1)"
 

User Function COMP011_MVC()

Local aArea   := GetArea()
Local oBrowse
     
//Inst�nciando FWMBrowse - Somente com dicion�rio de dados
oBrowse := FWMBrowse():New()
     
//Setando a tabela de cadastro de Autor/Interprete
oBrowse:SetAlias("SBM")
 
//Setando a descri��o da rotina
oBrowse:SetDescription(cTitulo)
     
//Legendas
oBrowse:AddLegend( "SBM->BM_PROORI == '1'", "GREEN",    "Original" )
oBrowse:AddLegend( "SBM->BM_PROORI == '0'", "RED",    "N�o Original" )
oBrowse:AddLegend( "SBM->BM_PROORI == ''", "BLUE",    "N�o Escolhido" )
     
//Ativa a Browse
oBrowse:Activate()
     
RestArea(aArea)

Return Nil
 
 
Static Function MenuDef()

Local aRot := {}
     
//Adicionando op��es
ADD OPTION aRot TITLE 'Visualizar' ACTION 'VIEWDEF.COMP011_MVC' OPERATION MODEL_OPERATION_VIEW   ACCESS 0 //OPERATION 1
ADD OPTION aRot TITLE 'Legenda'    ACTION 'u_zMVC01Leg'     OPERATION 6                      ACCESS 0 //OPERATION X
ADD OPTION aRot TITLE 'Incluir'    ACTION 'VIEWDEF.COMP011_MVC' OPERATION MODEL_OPERATION_INSERT ACCESS 0 //OPERATION 3
//ADD OPTION aRot TITLE 'Alterar'    ACTION 'VIEWDEF.zMVCMd1' OPERATION MODEL_OPERATION_UPDATE ACCESS 0 //OPERATION 4
//ADD OPTION aRot TITLE 'Excluir'    ACTION 'VIEWDEF.zMVCMd1' OPERATION MODEL_OPERATION_DELETE ACCESS 0 //OPERATION 5
 
Return aRot
 
 
Static Function ModelDef()

//Cria��o do objeto do modelo de dados
Local oModel := Nil
     
//Cria��o da estrutura de dados utilizada na interface
Local oStSBM := FWFormStruct(1, "SBM")
     
//Instanciando o modelo, n�o � recomendado colocar nome da user function (por causa do u_), respeitando 10 caracteres
oModel := MPFormModel():New("zMVCMd1M",/*bPre*/, /*bPos*/,/*bCommit*/,/*bCancel*/)
     
//Atribuindo formul�rios para o modelo
oModel:AddFields("FORMSBM",/*cOwner*/,oStSBM)
     
//Setando a chave prim�ria da rotina
oModel:SetPrimaryKey({'BM_FILIAL','BM_GRUPO'})
     
//Adicionando descri��o ao modelo
oModel:SetDescription("Modelo de Dados do Cadastro "+cTitulo)
     
//Setando a descri��o do formul�rio
oModel:GetModel("FORMSBM"):SetDescription("Formul�rio do Cadastro "+cTitulo)

Return oModel
 
 
Static Function ViewDef()
//Cria��o do objeto do modelo de dados da Interface do Cadastro de Autor/Interprete
Local oModel := FWLoadModel("COMP011_MVC")
     
//Cria��o da estrutura de dados utilizada na interface do cadastro de Autor
Local oStSBM := FWFormStruct(2, "SBM")  //pode se usar um terceiro par�metro para filtrar os campos exibidos { |cCampo| cCampo $ 'SBM_NOME|SBM_DTAFAL|'}
     
//Criando oView como nulo
Local oView := Nil
 
//Criando a view que ser� o retorno da fun��o e setando o modelo da rotina
oView := FWFormView():New()
oView:SetModel(oModel)
    
//Atribuindo formul�rios para interface
oView:AddField("VIEW_SBM", oStSBM, "FORMSBM")
     
//Criando um container com nome tela com 100%
oView:CreateHorizontalBox("TELA",100)
     
//Colocando t�tulo do formul�rio
oView:EnableTitleView('VIEW_SBM', 'Dados do Grupo de Produtos' ) 
     
//For�a o fechamento da janela na confirma��o
oView:SetCloseOnOk({||.T.})
     
//O formul�rio da interface ser� colocado dentro do container
oView:SetOwnerView("VIEW_SBM","TELA")

Return oView
 
User Function zMVC01Leg()

Local aLegenda := {}
     
//Monta as cores
AADD(aLegenda,{"BR_VERDE",        "Original"  })
AADD(aLegenda,{"BR_VERMELHO",    "N�o Original"})
     
BrwLegenda("Grupo de Produtos", "Procedencia", aLegenda)

Return