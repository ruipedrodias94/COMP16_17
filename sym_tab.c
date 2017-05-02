#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "sym_tab.h"
#include <ctype.h>


/*
node_ cria_lista_nodes (void)
  {
    node_ aux;
    aux = (node_) malloc (sizeof (_node));
    if (aux != NULL) {
      aux->name = (char *)malloc(sizeof(char)*2);
      strcpy(aux->name, "");
      aux->type = (char *)malloc(sizeof(char)*2);
      strcpy(aux->type, "");
      aux->next = NULL;
    }
    return aux;
}

tab_ cria_lista_tab (void)
  {
    tab_ aux;
    aux = (tab_) malloc (sizeof (_tab));
    if (aux != NULL) {
      aux->name = (char *)malloc(sizeof(char)*2);
      strcpy(aux->name, "");
      aux->type = (char *)malloc(sizeof(char)*2);
      strcpy(aux->type, "");
      aux->params = (char *)malloc(sizeof(char)*2);
      strcpy(aux->params, "");
      aux->node = (tab_) malloc(sizeof(_node));
      aux->next = NULL;
    }
    return aux;
}

node_ insere_lista_nodes(node_ lista, char *name, char *type)
{
    node_ aux = lista;
    node_ novo_no;

    while (aux -> next !=  NULL)
        aux = aux-> next;
    if ((novo_no = (node_) malloc (sizeof(node_)))!= NULL)
    {
        novo_no->name = (char*) malloc(strlen(name));
        novo_no->name = name;
        novo_no->type = (char*) malloc(strlen(type));
        novo_no->type = type;
        novo_no -> next = NULL;
    }
    aux->next = novo_no;
    return lista;
}

tab_ insere_lista_tab (tab_ lista, char *name, char *type, char *params, node_ node)
{
    tab_ aux = lista;
    tab_ novo_no = NULL;

    while (aux -> next !=  NULL)
        aux = aux-> next;

    if ((novo_no = (tab_) malloc (sizeof(tab_)))!= NULL)
    {

      novo_no->name = (char *)malloc(sizeof(char) + strlen(name));
      novo_no->name = name;
      novo_no->type = (char *)malloc(sizeof(char) + strlen(type));
      novo_no->type = type;
      novo_no->params = (char *)malloc(sizeof(char) + strlen(params));
      novo_no->node = (node_) malloc(sizeof(_node));
      novo_no->node = node;
      novo_no->next = NULL;
    }
    aux->next = novo_no;
    return lista;
}
*/

/* nova funcao imprimir*/

void imprime_lista_2 (tab_ tabela)
{

  tab_ tab_aux = tabela;
  while (tab_aux!=NULL)
  {
    printf("===== %s %s Symbol Table ===== \n", tab_aux->type, tab_aux->name);

    tab_ aux = tab_aux->node->next;
    while(aux!=NULL)
    {
      printf("%s\t%s\t \n", aux->name, aux->type);
      aux = aux->next;
    }
    printf("\n");
    tab_aux = tab_aux->next;
  }
}




/*void imprime_lista (tab_ lista)
{
  tab_ l = lista;
  while (l!=NULL)
  {
    printf("===== %s %s Symbol Table ===== \n", l->type, l->name);
    node_ aux = l->node;
    while(aux!=NULL)
    {
      printf("%s\t%s\t \n", aux->name, aux->type);
      aux = aux->next;
    }
    printf("\n");
    l=l->next;
  }
}
*/
/*Fazer os métodos de obter os parâmetros*/

/*Fazer o método de meter os parametros com letra minuscula*/




// nova implementacao

tab_ cria_tabela (char *name, char *params )
  {
    tab_ aux;
    aux = (tab_) malloc (sizeof (_tab));
    if (aux != NULL) {
      aux->name = (char *)malloc(sizeof(char)*2);
      strcpy(aux->name, name);
      aux->type = (char *)malloc(sizeof(char)*2);
      strcpy(aux->type, "Class");
      aux->params = (char *)malloc(sizeof(char)*2);
      strcpy(aux->params, "");
      aux->node = (tab_) malloc(sizeof(tab_));
      aux->next = NULL;
    }
    return aux;
}

void add_global_symbol(tab_ t, char *name, char *type)
{
  tab_ aux = t->node;
  tab_ novo_no;

  while(aux->next!=NULL)
  {
    aux = aux->next;
  }
  if ((novo_no = (tab_) malloc (sizeof(tab_)))!= NULL)
  {

    novo_no->name = (char *)malloc(sizeof(char) + strlen(name));
    novo_no->name = name;
    novo_no->type = (char *)malloc(sizeof(char) + strlen(type));
    novo_no->type = type;
    novo_no->params = NULL;
    novo_no->node = NULL;
    novo_no->next = NULL;
  }
  aux->next = novo_no;
}
/*
void add_global_method(tab_ t, char *name, char *type, char *params)
{
  tab_ aux = t->node;
  tab_ novo_no;

  while(aux->next!=NULL)
  {
    aux = aux->next;
  }
  if ((novo_no = (tab_) malloc (sizeof(tab_)))!= NULL)
  {

    novo_no->name = (char *)malloc(sizeof(char) + strlen(name));
    novo_no->name = name;
    novo_no->type = (char *)malloc(sizeof(char) + strlen(type));
    novo_no->type = type;
    novo_no->params = NULL;
    novo_no->node = NULL;
    novo_no->next = NULL;
  }
  aux->next = novo_no;
}
*/
char *strlwr(char *str)
{
  unsigned char *p = (unsigned char *)str;

  while (*p) {
     *p = tolower((unsigned char)*p);
      p++;
  }

  return str;
}
