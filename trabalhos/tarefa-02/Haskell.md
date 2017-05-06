# A Linguagem Haskell
---
## Origens da Linguagem

A linguagem de programação Haskell surgiu em 1990, mas a história das linguagens funcionais (sua definição será vista posteriormente) começou bem antes disso. Tudo isso começa na década de 1930.

* Década de 1930: Alonzo Church cria o Cálculo Lambda. Seu propósito não era para ser usado em computadores, mas sim era mostrar (em forma de modelo matemático) as relações que haviam entre as funções. A partir deste modelo matemático criado por ele, era possível mostrar que, a partir de funções simples que se relacionavam, era possível criar funções mais complexas, podendo, muito amplamente, modelar comportamentos.

* Década de 1950: é criada a primeira linguagem de programação que continha cálculo Lambda, o LISP. Esta linguagem foi criada por John McCarthy. Foi considerada a segunda linguagem de programação criada no mundo, a primeira foi FORTRAN.  Até hoje sistemas são feitos em Lisp, principalmente para uso em Inteligência Artificial. **Observação:** não era uma linguagem 100% funcional, pois havia elementos da programação imperativa, como a atribuições de variáveis, mudanças de estados, entre outros. 

*  Década de 1960: é criada a primeira linguagem de programação que era puramente funcional, grandemente baseada em cálculo Lambda, a linguagem ISWIN.

* Década de 1970: é desenvolvido a linguagem FP (*Functional Programming*, em português "Programação Funcional"), "uma linguagem de programação funcional que enfatiza as funções de alto nível" (VEDOVATTO, COSTA, p. 3). Além disso, é criada a linguagem ML, considerada a primeira linguagem de programação funcional moderna, pois criava o conceito de polimorfismo de funções.

* 1978: a grande "alavanca" da programação funcional. John Backus, criador do BNF, publicou um artigo, onde nele ele criticava as linguagens imperativas, pois, segundo ele, as novas gerações de linguagens herdariam falhas de projeto das linguagens antigas e adicionariam novas falhas; estas, por sua vez, seriam herdadas pelas próximas gerações. Assim, essas linguagens apenas cresceriam de tamanho (ou, segundo ele, apenas engordavam), porém, não aumentariam seu poder. Neste artigo, tal argumentação foi demonstrada, e assim exaltando a Programação Funcional.

* Década de 1980:  durante a década de 1980, os pesquisadores da Programação Funcional estavam em um ritmo de pesquisa alto. Resultado destas pesquisas: mais de 12 linguagens funcionais foram criadas neste período, sendo estas as principais: **Miranda**, LML (Lazy (será explicado posteriormente) ML), Orwell, entre outros.

* 1987: em setembro de 1987, foi realizada uma conferência chamada *Functional Programming Languages and Computer Architecture (FPCA 1987)*. O objetivo dela era unificar as linguagens de programação funcionais, criando uma única padrão, seria um padrão aberto para as linguagens.

* 1988: em janeiro, é realizada a primeira reunião do comitê da conferência, onde algumas metas foram discutidas para criar essa linguagem padrão funcional. Alguns dos objetivos para essa nova linguagem:
	- Que fosse viável para o ensino, ou seja, uma linguagem didática; além disso, para a pesquisa e aplicações;
	- Que devesse reduzir a diversidade desnecessária de linguagens funcionais que existiam;
	- Que não fosse proprietária, ou seja, que fosse aberta, a ponto de qualquer um poder implementá-la e distribuí-la;
	- Que se baseasse nas melhores práticas que houvessem nas linguagens funcionais; 
	- Entre outros.

* 1º de Abril de 1990: é definida,e lançada, a primeira versão do Haskell. Foi criada por Simon Peyton-Jones, Paul Hudak e Philip Walder. O nome da linguagem, Haskell, é em homenagem ao lógico Haskell Curry.  

* 1999: saiu uma versão estável, mínima e portável do Haskell, com o nome de Haskell 98.

Hoje em dia, a versão mais nova estável da linguagem é o Haskell 2010.

"Haskell é a linguagem funcional sobre a qual mais pesquisa
está sendo realizada, nela tem-se a oportunidade de ver como conceitos matemáticos abstratos
se relacionam diretamente com os comandos e estruturas que são construídas." (O'SULLIVAN apud VEDOVATTO, COSTA, p.5)

## A *lazy evaluation* (avaliação preguiçosa)

Um dos conceitos mais importantes da programação funcionais é o conceito de *lazy evaluation*, também conhecida como "avaliação preguiçosa".

Avaliação preguiçosa é uma estratégia de avaliação que "segura" a avaliação de uma expressão até o momento que seja necessário o seu valor, atrasa a computação até seu resultado seja necessário.

É o oposto da avaliação ansiosa, onde neste tipo de avaliação, na primeira vez que encontra a expressão, já é avaliada, e já é visto seu valor.

Sua importância será vista posteriormente

## Influências do Haskell

Como o Haskell foi uma linguagem que veio com o objetivo de padronizar, devido a grande quantidade de linguagens funcionais que haviam, naturalmente a linguagem receberia influências das linguagens funcionais que já existiam.

Um site, que mostra as influências entre as linguagens de programação mostra que o Haskell foi influenciado principalmente pelo ML, Miranda e Lisp.

![Linguagem Haskell e suas influências](haskell.png)

Fonte: https://exploringdata.github.io/vis/programming-languages-influence-network-2014/#Haskell

## Classificação do Haskell

**Quanto ao paradigma**: o Haskell é considerado uma linguagem de programação do Paradigma Funcional, ou seja, é uma Linguagem de Programação Funcional. 

### A Programação Funcional

Programação Funcional é um paradigma onde toda a computação é feita a partir de funções matemática, e não há mudança de estado, isto é, ao definir algo com um determinado valor, ele se torna imutável.

Outras características da Programação Funcional:
	
* Os programas possuem apenas funções puras, isto é, são funções que não possuem efeitos colaterais. Efeito colateral seria algo externo que acontecesse na função, como uma entrada de usuário, uma saída para o console, entre outros. Outra forma de entender função pura é o fato de que elas podem ser trocadas pelo seu valor de retorno;

* Cálculo Lambda;

* Entre outros.

---
**Quanto a tipagem**: o Haskell é uma linguagem estática, mas que não é necessário a declaração do tipo, ou seja, pode parecer dinâmica, mas como foi tipo anteriormente, ao definir algo, ele será imutável, logo, implicitamente ele define o tipo.

**Compilada ou Interpretada?** A linguagem Haskell possui um interpretador interativo, similar ao que o Python tem, mas a linguagem Haskell também é compilada. Ou seja, você pode compilar um código Haskell para rodar em forma de EXE, ou interpretá-lo, como um script.

**Quanto ao uso**: "Apesar da citada proximidade com a matemática, a linguagem Haskell é uma linguagem de propósito geral; portanto, pode-se criar qualquer tipo de programa com ela" (VEDOVATTO, COSTA). Ou seja, pode parecer que seja para o fim específico da Computação Científica, mas não é o foco do Haskell. Ela tem o foco geral que uso em sistemas em geral, além de ser usada no ensino e pesquisa.

## Avaliação da linguagem Haskell, quanto a redigibilidade e legibilidade (writability x readability)

Ao analisarmos este código em Haskell:

```haskell  
module Main where  
  
somaidades :: [Integer] -> Integer  
somaidades lista=(sum lista)*5  
  
main = print (somaidades [21,52,52,34,40,15,60,3])  
```  

Percebe-se que este código pega uma lista com inteiros, que seriam idades de algumas pessoas, usa-o como parâmetro da função somaidades, e retorna a soma das idades, multiplicado por 5. Qual a aplicação dela? Não é o foco deste artigo.

O que se deve focar neste código é o fato de, em apenas 4 linhas de código Haskell, sendo 1 chamando a "main" do código, duas para definir a função somaidades, e uma outra sendo a main em si, onde seria o "núcleo" do programa funcional, a programação toda foi feita. Se formos apenas "contar" as linhas que possuem instruções importantes para o programa, de 4 seriam apenas 2, as linhas 4 e 6. 

O Haskell consegue ser uma linguagem onde "escrevendo pouco se programa muito", digamos assim. Em outras palavras, com poucas linhas de código Haskell é possível programar todo o programa funcional, gerando programas "condensados" no que diz sobre tamanho do código. Isto mostra que a linguagem funcional Haskell tem boa **redigibilidade (writability)**.

Linguagens que possuem boa redigibilidade são linguagens que permitem ao programador programar menos linhas de código, mas no que diz sobre a semântica do programa, ou seja, o que o programa faz, ele tem muito significado, ou que então faz muita computação. O "programa quer dizer o que significa", porém com poucas linhas de código.

Tal diferença de redigibilidade pode ser percebida se compararmos o mesmo problema, mas com um código feito em linguagem imperativa C:

```c
#include <stdio.h>  
int somaidades(int[]);  
int somaidades(int idades[]){  
 	int soma=0;  
   	while(1){  
 		  if((*idades)==NULL)  
 		      	break;  
 		  soma+=*idades;  
 		  idades++;  
      }  
	return soma*5;  
 }  
 int main(){  
	int idades[]={21,52,34,40,15,60,3,NULL};  
	printf("%d",somaidades(idades));  
 }  
```

Um código programado em C para resolver o mesmo problema usou o quádruplo de linhas que foram usadas no Haskell (4 do Haskell contra 16 do C). Se for contar apenas linhas que contenham instruções, tal relação aumenta para um pouco mais que o quádruplo (2 do Haskell contra 9 do C).

Em contrapartida, essa "condensação de código" por parte do Haskell pode gerar uma queda no quesito legibilidade, pois com código menores, mais difícil fica entender qual o propósito do programa. Tal diferença talvez pode não ser vista nestes códigos, pois o problema é um problema menor, mas em casos maiores, a legibilidade fica mais a desejar no caso do Haskell em relação ao C, por exemplo. 

## A expressividade da linguagem Haskell, em relação a outras

Como já foi dito anteriormente, a linguagem Haskell possui um recurso, que é o da avaliação lazy, onde ele só vai avaliar a expressão somente quando for necessário.

Uma das grandes vantagens desse tipo de avaliação é evitar o desperdício de recursos que poderiam ser alocados no programa.

Além dessa vantagem, existe outra, que gera um fator de expressividade para a linguagem Haskell, em comparação a outras, que é o de poder fazer **listas infinitas**. Exatamente, listas infinitas.

Mas como pode ser computacionalmente realizada uma lista infinita, se, em teoria, isto fará com que o sistema "quebre"? Se só houver uma definição de lista infinita, por exemplo, mas ele no programa não for usado, a lista ficará somente na definição. Mas, se ele for pedido dentro do programa, ele só irá avaliar a demanda desejada, ou seja, não avaliaria a lista toda, até porque possui infinitos elementos, mas sim a quantidade de elementos desejados.

(Exemplo extraído do site https://marceloparrela.wordpress.com/tag/haskell/) Se houvéssemos, no interpretador *ghci*, estes comandos digitados e executados:

```haskell
ghci> let a = [1..]  
ghci> let b = 5^2  
ghci> print b  
25
```

O interpretador irá somente computar o 'b', e não irá avaliar a expressão 'a', portanto, 'a' ainda não passará de uma mera definição de lista infinita.

Usando como base o texto de Parrela, que está na última referência da bibliografia, temos que: no Haskell não há sequência de comandos, e sim definições de funções, que só serão avaliadas quando forem necessárias, no caso do exemplo acima, a lista infinita só seria avaliada se caso houvesse alguma função o usando.

Veja neste outro exemplo outra referência a lista infinita, desta vez com o seu uso:

```haskell
ghci> take 15(iterate (2*) 1)
[1,2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384]
```

Esta linha no interpretador fará o seguinte: o comando mais interno, *iterate*, passeará a lista infinita fazendo a i-ésima função composta definida no primeiro parâmetro, na i-ésima posição, com o valor, determinado no segundo parâmetro (a partir da segunda posição, na primeira é usada o valor dado como parâmetro), isto é, a lista ficaria assim, com a definição usada no exemplo:
[1,f(1),f(f(1)),f(f(f(1))), ...]

Com isso, a lista é formada pelos valores das potências binárias (1,2,4,8,16, ...).

Contudo, o Haskell não processará toda a lista, avaliará somente a demanda desejada pela função *take*, que tem como finalidade recuperar os n primeiros da lista dada como parâmetro; isto é, os 15 primeiros.

Estes exemplos mostram como a lista infinita pode ser usada no Haskell, ela só será avaliada quando necessária, e ainda assim somente na demanda desejada.

Tal recurso não é possível de ser usado em linguagens mais familiarizadas de todos, como C, Pascal, entre outros, sendo para o Haskell um fator de expressividade a seu favor. 

## Conclusão

A linguagem Haskell veio com o objetivo de "unificar' todas as linguagens funcionais que existiam até suas criação. Isto facilitou as pesquisas da área, pois ele conseguiu colocar vários recursos que haviam entre as linguagens de programação funcionais em uma só.

Por sua boa redigibilidade, seus códigos são, quase sempre, condensados, pequenos, mas que, muitas vezes, pode pecar em sua legibilidade, gerando um pouco de dificuldade de entender o que o programa faz.

A Haskell mostra que um problema pode ser visto como uma sequência de execução de funções matemáticas simples, que, uma após a outra, passando o resultado de uma função passa a próxima, pode-se chegar ao resultado esperado, ou seja, um problema pode ser dividido em pequenas funções simples para que se possa chegar ao resultado desejado.


## Bibliografia

* (PARRELA, M.) Haskell Básico - A História: https://marceloparrela.wordpress.com/2013/11/01/haskell-a-historia/

* Haskell (Linguagem de Programação) - Wikipédia, a enciclopédia livre: https://pt.wikipedia.org/wiki/Haskell_(linguagem_de_programa%C3%A7%C3%A3o)

* (BOSCAGLIA, B. S., SATLER, P. S., MATOS, R. P.) Haskell: http://www.inf.ufes.br/~vitorsouza/wp-content/uploads/teaching-lp-20132-seminario-haskell.pdf

* Avaliação Preguiçosa - Unionpédia, o mapa conceitual: http://pt.unionpedia.org/Avalia%C3%A7%C3%A3o_pregui%C3%A7osa

* Programação funcional avaliação preguiçosa: http://www.w3ii.com/pt/functional_programming/functional_programming_lazy_evaluation.html

* (CARNEIRO, T.) Linguagem Haskell: http://www.ppgsc.ufrn.br/~rogerio/material_auxiliar/CLP20132_introducao_haskell.pdf

* Programação Funcional I: Imutabilidade e Funções Puras (Scala):https://codingcreeper.wordpress.com/2013/11/19/programacao-funcional-1-imutabilidade-e-funcoes-puras/

* Haskell em 10 minutos - HaskellWiki: https://wiki.haskell.org/Haskell_em_10_minutos

* (LIMA, M. A. V.) Introdução a Programação ao Funcional - Linguagem Haskell: http://www.facom.ufu.br/~madriana/PF/hs.pdf

* HaskellWiki: https://wiki.haskell.org/Haskell

* (PARRELA, M.) Haskell Básico – Uma Pequena Introdução – Parte 3: https://marceloparrela.wordpress.com/tag/haskell/

* (VASCONCELOS, P.) Listas Infinitas: http://www.dcc.fc.up.pt/~pbv/aulas/pf/slides/aula8.pdf

* Haskell: Lazy Evaluation e Listas: http://aterribili.blogspot.com/2014/02/haskell-lazy-evaluation-e-listas.html

* Um pouco sobre Lazy Evaluation em Haskell: http://blog.haskellbr.com/2016/01/17/lazy-evaluation-em-haskell.html
