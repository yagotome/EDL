# Trabalho-01 - Go

## Introdução

Go é uma linguagem de programação de código aberto (open source) desenvolvida pela Google, anunciada em 2009, projetada para programação de sistemas.

Atualmente, há implementações para Windows, Linux, Mac OS X e FreeBSD.

## Origens e Influências

Go teve sua origem como um projeto de uma nova linguagem de programação de sistemas, de modo que ela:

* Fosse estaticamente tipada, escalável para grandes sistemas
* Fosse produtiva e legível (readable), sem palavras-chave obrigatórias e repetições demais
* Não requeresse ferramentas, embora suportasse bem elas
* Desse suporte a redes e multiprocessamentos

Com isso, Go teve influências de muitas linguagens, como Alef, APL, BCPL, C, CSP, Limbo, Modula, Newsqueak, Oberon, occam, Pascal, Python e Smalltalk.

## Classificação

Go é uma linguagem de paradigmas imperativa e estruturada.

Ela é compilada estaticamente e é concorrente.

Go é fortemente tipada.

## Avaliação Comparativa

Go é no estilo de C, mas têm muitas mudanças para melhorar a concisão, simplicidade e segurança. Segue é um breve resumo das características de Go:

* Uma sintaxe e ambiente adotando padrões mais comuns em linguagens dinâmicas:
  * Declaração de variável de forma concisa e inicialização através de inferência de tipos (Opcional) [x: = 0 ao invés de int x = 0]
  * Rápido tempo de compilação
  * Gerenciamento remoto de pacote e documentação do pacote online
* Abordagens distintas para problemas específicos
  * Concorrência primitiva embutida: "light-weight processes" (goroutines), "channels", e o "select statement".
  * Uma interface de sistema no lugar da herança virtual, tipo e embutido em vez de herança não virtual
  * Um conjunto de ferramentas que, por padrão, produz estaticamente binários nativos já "linkados" (linked), sem dependências externas
* Um desejo de manter a especificação linguagem simples o suficiente para manter na cabeça de um programador, em parte, ao omitir características comuns às linguagens semelhantes

Alguns pontos negativos frequentemente criticado:
* Falta de tempo de compilação genérica leva a duplicação de código. "Metaprogramação" não pode ser estaticamente verificada e a biblioteca padrão não oferece algoritmos genéricos.
* Falta de extensibilidade de linguagem (através, por exemplo, da sobrecarga de operador) faz determinadas tarefas mais detalhadas.
* Falta do sistema de tipo constante (const) ou tipo Hindley-Milner inibe a segurança e/ou expressividade.
* As pausas e sobrecarga de uso do garbage collector limita o uso de Go à programação de sistemas em comparação com linguagens com gerenciamento de memória manual

## Conclusão

Go é uma linguagem nova, que ainda está em desenvolvimento, na versão atual 1.6.

Go é uma linguagem fortemente projetada, e que é muito eficaz para programção de sistemas, em opção a C, por exemplo.

No entanto, por suas características, ela não é muito produtivo para projetos em que o nível de abstração é prioridade, como por exemplo, sistemas web, mobile ou até desktop.
