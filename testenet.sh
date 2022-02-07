#!/bin/bash
#
# AUTOR:        Julio C. Pereira
# APLICATIVO:   Realiza testes para determinado ip de destino
#               no sentido de identificar se há conectividade
#               ou/e identificar problemas de qualidade do
#               serviço.
#
# CONTATO:      julliopereira@gmail.com
#
# versão: 0.1 - Inicio do desenvolvimento
#               20220205
#               Julio C. Pereira
# versão: 0.2 - Incluído opção de versionamento
#               20220206
#               Julio C. Pereira
#
#
# 
#
##########################################################
# -- MENSAGENS --
msghelp="
Uso: $(basename "$0")-[fmnpthV] <ip_de_destino>

        -f,           (file)    Redireciona para arquivo
        -g,           (geo)     Mostra cidade e estado de localização do ip de destino
        -m,           (mtr)     Faz análise com mtr para o destino
        -n,           (nmap)    Faz uma avaliação com nmap -A para o destino (root)
        -p,           (ping)    Testa conectividade para o destino (3 pings)
        -q,           (ping -Q) Envia pacote marcado com EF,AF41,AF31,AF21,AF11 para o destino
                      - destino deve retornar com EF,AF41,AF31,AF21,AF11
        -t,           (trace)   Faz um tracert para o destino
        -h,           (ajuda)   Mostra ajuda do programa
        -V,           (versão)  Mostra a versão do programa

    Exemplos:

    -Realiza teste de conectivodade para o ip de destino e salva resultado em arquivo
        $(basename "$0") -f /tmp/arquivo 192.168.12.10

    -Monitora qualidade do caminho de rede até o ip de destino
        $(basename "$0") -m 192.168.12.10

    -Realiza teste de conectividade e traça rota até o ip de destino
        $(basename "$0") -p -t 192.168.12.10

    -(root)Realiza análise para identificar recursos do dispositivo que contém o ip destino 
        $(basename "$0") -n 192.168.12.10
"
msgopcoes="
    $(basename "$0") : Opção: $OPTARG incorreta
"
# -- VARIÁVEIS --

icmp="0"    # PINGAR ?
trace="0"   # TRAÇAR ROTA ?
nmap="0"    # ANALISAR DISPOSITIVO ?
mtr="0"     # MONITORAR QUALIDADE DO TRÁFEGO ?
ip="$2"       # IP DE DESTINO

# -- FUNÇÕES --

file_func() {

}
geo_func() {

}

mtrrun_func() {
    mtr -t $ip 
}
ajuda_func() {
    echo -e "$msghelp"
}
erro_func() {
    echo -e "$msgopcoes"
}

# -- CORPO --

while getopts ":m" opc
do
    case $opc in
        f) file_func ;;
        g) geo_func ;;
        m) mtrrun_func ;;
        h) ajuda_func ;;
        V) egrep -A 2 "^# versão" testenet.sh | tail -n 3 ;;
       \?) Opção: $opc incorreta ;;
        :) erro_func exit 1 ;;
    esac
done 

# -- SAÍDA --
exit 0