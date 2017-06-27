import Html exposing (text)

main=text(toString (avaliarPrograma programa))

-- programa exemplo
programa : Comando
programa = (Seq
            (Attr "x" (Num 50))
            (Seq
              (While (Var "x") (Attr "x" (Sub (Var "x") (Num 1))))
              (If (Var "x")
                (Attr "ret" (Var "x"))
                (Attr "ret" (Add (Var "x") (Num 1))))))
              
-- Tipos criados

type Exp = Num  Int |
           Add  Exp Exp |
           Sub  Exp Exp |
           Mult Exp Exp |
           Div  Exp Exp |
           Var  String

type Comando = Seq  Comando Comando  |
               Attr String Exp       |
               If Exp Comando Comando|
               While Exp Comando
             
type alias Ambiente = (String -> Int)

-- Funções criadas

avaliarExpressao: Ambiente -> Exp -> Int
avaliarExpressao  ambiente exp = 
          case exp of
            Add  e1 e2 -> (avaliarExpressao ambiente e1) +  (avaliarExpressao ambiente e2)
            Sub  e1 e2 -> (avaliarExpressao ambiente e1) -  (avaliarExpressao ambiente e2)
            Mult e1 e2 -> (avaliarExpressao ambiente e1) *  (avaliarExpressao ambiente e2)
            Div  e1 e2 -> (avaliarExpressao ambiente e1) // (avaliarExpressao ambiente e2)
            Num  i      -> i
            Var  var    -> ambiente var
            
avaliarComando: Comando -> Ambiente -> Ambiente
avaliarComando  com ambiente = 
          case com of
            Seq c1 c2       -> (avaliarComando c2 (avaliarComando c1 ambiente))
            Attr var exp    -> let val = (avaliarExpressao ambiente exp) in 
                                  (\v -> if v==var then
                                           val
                                         else
                                           ambiente v)
            If cond sev sef -> if (avaliarExpressao ambiente cond)/=0 then
                                avaliarComando sev ambiente
                               else
                                avaliarComando sef ambiente
            While exp cmd   -> if (avaliarExpressao ambiente exp)/=0 then
                                avaliarComando com (avaliarComando cmd ambiente)
                               else
                                ambiente
            
ambientevazio: Ambiente
ambientevazio= \variavel -> 0

avaliarPrograma: Comando -> Int
avaliarPrograma prog = ((avaliarComando prog ambientevazio) "ret")