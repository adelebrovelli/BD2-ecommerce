import mysql.connector
from getpass import getpass

# ========== CREDENCIAIS ==========
SENHAS = {
    'admin': 'pass',
    'gerente': 'pass',
    'funcionario': 'pass'
}

def conectar(user, senha, database):
    try:
        return mysql.connector.connect(
            host='localhost',
            user=user,
            password=senha,
            database=database
        )
    except mysql.connector.Error as err:
        print(f"Erro na conexão: {err}")
        return None

# ========== FUNÇÕES AUXILIARES ==========
def consultar_tabela(banco, tabela):
    conexao = conectar(usuario, SENHAS[usuario], banco)
    if not conexao:
        return
    cursor = conexao.cursor()
    cursor.execute(f"SELECT * FROM {tabela}")
    resultados = cursor.fetchall()
    if resultados:
        for linha in resultados:
            print(linha)
    else:
        print(f"Não há dados disponíveis na tabela {tabela}.")
    cursor.close()
    conexao.close()

def cadastrar_cliente(usuario, banco):
    nome = input("Nome do cliente: ")
    conexao = conectar(usuario, SENHAS[usuario], banco)
    if not conexao:
        return
    cursor = conexao.cursor()
    try:
        cursor.execute("INSERT INTO cliente (nome) VALUES (%s)", (nome,))
        conexao.commit()
        print("Cliente cadastrado com sucesso.")
    except:
        print("Erro ao cadastrar cliente.")
    cursor.close()
    conexao.close()

def cadastrar_produto(usuario, banco):
    nome = input("Nome do produto: ")
    valor = float(input("Valor do produto: "))
    quantidade = int(input("Quantidade: "))
    conexao = conectar(usuario, SENHAS[usuario], banco)
    if not conexao:
        return
    cursor = conexao.cursor()
    try:
        cursor.execute("INSERT INTO produto (nome, valor, quantidade) VALUES (%s, %s, %s)", (nome, valor, quantidade))
        conexao.commit()
        print("Produto cadastrado com sucesso.")
    except:
        print("Erro ao cadastrar produto.")
    cursor.close()
    conexao.close()

def editar_cliente(usuario, banco):
    nome = input("Nome do cliente a editar: ")
    novo_nome = input("Novo nome: ")
    conexao = conectar(usuario, SENHAS[usuario], banco)
    if not conexao:
        return
    cursor = conexao.cursor()
    cursor.execute("UPDATE cliente SET nome = %s WHERE nome = %s", (novo_nome, nome))
    if cursor.rowcount:
        conexao.commit()
        print("Cliente atualizado.")
    else:
        print("Cliente não encontrado.")
    cursor.close()
    conexao.close()

def editar_produto(usuario, banco):
    nome = input("Nome do produto a editar: ")
    novo_valor = float(input("Novo valor: "))
    nova_qtd = int(input("Nova quantidade: "))
    conexao = conectar(usuario, SENHAS[usuario], banco)
    if not conexao:
        return
    cursor = conexao.cursor()
    cursor.execute("UPDATE produto SET valor = %s, quantidade = %s WHERE nome = %s", (novo_valor, nova_qtd, nome))
    if cursor.rowcount:
        conexao.commit()
        print("Produto atualizado.")
    else:
        print("Produto não encontrado.")
    cursor.close()
    conexao.close()

def remover_cliente(usuario, banco):
    nome = input("Nome do cliente a remover: ")
    conexao = conectar(usuario, SENHAS[usuario], banco)
    if not conexao:
        return
    cursor = conexao.cursor()
    cursor.execute("DELETE FROM cliente WHERE nome = %s", (nome,))
    if cursor.rowcount:
        conexao.commit()
        print("Cliente removido.")
    else:
        print("Cliente não encontrado.")
    cursor.close()
    conexao.close()

def remover_produto(usuario, banco):
    nome = input("Nome do produto a remover: ")
    conexao = conectar(usuario, SENHAS[usuario], banco)
    if not conexao:
        return
    cursor = conexao.cursor()
    cursor.execute("DELETE FROM produto WHERE nome = %s", (nome,))
    if cursor.rowcount:
        conexao.commit()
        print("Produto removido.")
    else:
        print("Produto não encontrado.")
    cursor.close()
    conexao.close()

def executar_procedure(usuario, banco):
    conexao = conectar(usuario, SENHAS[usuario], banco)
    if not conexao:
        return
    cursor = conexao.cursor()
    print("Procedures disponíveis: reajuste_salario, sorteio, registrar_venda, estatisticas")
    nome = input("Nome da procedure: ").strip()
    try:
        if nome == 'reajuste_salario':
            perc = float(input("Percentual: "))
            cat = input("Categoria: ")
            cursor.callproc(nome, (perc, cat))
        elif nome == 'sorteio':
            cursor.callproc(nome)
        elif nome == 'registrar_venda':
            vend = input("Nome do vendedor: ")
            cli = input("Nome do cliente: ")
            prod = input("Nome do produto: ")
            cursor.execute("SELECT id FROM funcionario WHERE nome = %s", (vend,))
            id_v = cursor.fetchone()
            cursor.execute("SELECT id FROM cliente WHERE nome = %s", (cli,))
            id_c = cursor.fetchone()
            cursor.execute("SELECT id FROM produto WHERE nome = %s", (prod,))
            id_p = cursor.fetchone()
            if id_v and id_c and id_p:
                cursor.callproc(nome, (id_v[0], id_c[0], id_p[0]))
            else:
                print("Dados não encontrados.")
        elif nome == 'estatisticas':
            cursor.callproc(nome)
            for result in cursor.stored_results():
                for linha in result:
                    print(linha)
        else:
            print("Procedure não encontrada.")
        conexao.commit()
    except Exception as e:
        print("Erro ao executar procedure:", e)
    cursor.close()
    conexao.close()

def ver_views(usuario, banco):
    conexao = conectar(usuario, SENHAS[usuario], banco)
    if not conexao:
        return
    cursor = conexao.cursor()
    print("Views disponíveis: vendas_por_vendedor, clientes_total_gasto, estoque_produto")
    nome = input("Nome da view: ").strip()
    try:
        cursor.execute(f"SELECT * FROM {nome}")
        resultados = cursor.fetchall()
        if resultados:
            for linha in resultados:
                print(linha)
        else:
            print("View vazia.")
    except Exception as e:
        print("Erro ao acessar view:", e)
    cursor.close()
    conexao.close()

def criar_banco(usuario):
    nome = input("Nome do banco a ser criado: ")
    conexao = conectar(usuario, SENHAS[usuario], None)
    if not conexao:
        return
    cursor = conexao.cursor()
    try:
        cursor.execute(f"CREATE DATABASE {nome}")
        print("Banco criado com sucesso.")
    except:
        print("Erro ao criar banco.")
    cursor.close()
    conexao.close()

def destruir_banco(usuario):
    nome = input("Nome do banco a ser destruído: ")
    conexao = conectar(usuario, SENHAS[usuario], None)
    if not conexao:
        return
    cursor = conexao.cursor()
    try:
        cursor.execute(f"DROP DATABASE {nome}")
        print("Banco destruído com sucesso.")
    except:
        print("Erro ao destruir banco.")
    cursor.close()
    conexao.close()

# ========== MENUS ==========
def menu(usuario):
    while True:
        print(f"\n===== Menu Principal ({usuario}) =====")
        print("1. Cadastrar (funcionario, admin)")
        print("2. Editar (gerente, admin)")
        print("3. Remover (gerente, admin)")
        print("4. Consultar Clientes (funcionario, gerente, admin)")
        print("5. Consultar Produtos (funcionario, gerente, admin)")
        print("6. Executar Procedure (admin)")
        print("7. Ver Views (gerente, admin)")
        print("8. Criar Banco (admin)")
        print("9. Destruir Banco (admin)")
        print("0. Sair")
        opcao = input("Escolha: ")

        banco = input("Nome do banco: ").strip() if opcao != '0' else None

        if opcao == '1' and usuario in ['funcionario', 'admin']:
            tipo = input("Cadastrar cliente ou produto? ").strip().lower()
            if tipo == 'cliente': cadastrar_cliente(usuario, banco)
            elif tipo == 'produto': cadastrar_produto(usuario, banco)

        elif opcao == '2' and usuario in ['gerente', 'admin']:
            tipo = input("Editar cliente ou produto? ").strip().lower()
            if tipo == 'cliente': editar_cliente(usuario, banco)
            elif tipo == 'produto': editar_produto(usuario, banco)

        elif opcao == '3' and usuario in ['gerente', 'admin']:
            tipo = input("Remover cliente ou produto? ").strip().lower()
            if tipo == 'cliente': remover_cliente(usuario, banco)
            elif tipo == 'produto': remover_produto(usuario, banco)

        elif opcao == '4': consultar_tabela(banco, 'cliente')
        elif opcao == '5': consultar_tabela(banco, 'produto')
        elif opcao == '6' and usuario == 'admin': executar_procedure(usuario, banco)
        elif opcao == '7' and usuario in ['gerente', 'admin']: ver_views(usuario, banco)
        elif opcao == '8' and usuario == 'admin': criar_banco(usuario)
        elif opcao == '9' and usuario == 'admin': destruir_banco(usuario)
        elif opcao == '0': break
        else:
            print("Opção inválida ou sem permissão!")

# ========== LOGIN ==========
def login():
    print("Login no sistema")
    global usuario
    usuario = input("Usuário (admin/gerente/funcionario): ")
    senha = getpass("Senha: ")
    if usuario in SENHAS and senha == SENHAS[usuario]:
        print(f"Bem-vindo, {usuario}!")
        menu(usuario)
    else:
        print("Credenciais inválidas.")

if __name__ == "__main__":
    login()
