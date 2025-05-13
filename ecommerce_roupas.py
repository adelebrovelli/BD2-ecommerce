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

# ========== MENUS ==========
def menu(usuario):
    while True:
        print(f"\n===== Menu Principal =====")
        print("1. Cadastrar Cliente")
        print("2. Cadastrar Produto")
        print("3. Criar Banco (admin)")
        print("4. Destruir Banco (admin)")
        print("5. Executar Estatísticas")
        print("0. Sair")
        opcao = input("Escolha: ")

        if opcao == '1':
            banco = input("Nome do banco: ").strip()
            cadastrar_cliente(usuario, banco)
        elif opcao == '2':
            banco = input("Nome do banco: ").strip()
            cadastrar_produto(usuario, banco)
        elif opcao == '3' and usuario == 'admin':
            criar_banco(usuario)
        elif opcao == '4' and usuario == 'admin':
            destruir_banco(usuario)
        elif opcao == '5':
            banco = input("Nome do banco: ").strip()
            estatisticas(usuario, banco)
        elif opcao == '0':
            break
        else:
            print("Opção inválida ou sem permissão!")

# ========== FUNÇÕES ==========
def cadastrar_cliente(user, db):
    conn = conectar(user, SENHAS[user], db)
    if not conn:
        return
    cursor = conn.cursor()
    try:
        nome = input("Nome: ")
        sexo = input("Sexo (m/f/o): ")
        idade = input("Idade: ")
        nascimento = input("Nascimento (YYYY-MM-DD): ")
        cursor.execute("""
            INSERT INTO cliente (nome, sexo, idade, nascimento)
            VALUES (%s, %s, %s, %s)
        """, (nome, sexo, idade, nascimento))
        conn.commit()
        print("Cliente cadastrado.")
    except Exception as e:
        print("Erro:", e)
    finally:
        cursor.close()
        conn.close()

def cadastrar_produto(user, db):
    conn = conectar(user, SENHAS[user], db)
    if not conn:
        return
    cursor = conn.cursor()
    try:
        nome = input("Nome do produto: ")
        qtd = int(input("Quantidade: "))
        descricao = input("Descrição: ")
        valor = float(input("Valor: "))
        cursor.execute("""
            INSERT INTO produto (nome, quantidade, descricao, valor)
            VALUES (%s, %s, %s, %s)
        """, (nome, qtd, descricao, valor))
        conn.commit()
        print("Produto cadastrado.")
    except Exception as e:
        print("Erro:", e)
    finally:
        cursor.close()
        conn.close()

def criar_banco(user):
    nome_banco = input("Nome do novo banco: ").strip()
    if not nome_banco.isidentifier():
        print("Nome inválido.")
        return

    try:
        with open("bd2-ecommerce.sql", 'r') as f:
            script = f.read()
    except FileNotFoundError:
        print("Arquivo 'bd2-ecommerce.sql' não encontrado.")
        return

    try:
        conn = mysql.connector.connect(host='localhost', user=user, password=SENHAS[user])
        cursor = conn.cursor()

        cursor.execute(f"CREATE DATABASE IF NOT EXISTS {nome_banco}")
        cursor.execute(f"USE {nome_banco}")
        script = script.replace("USE empresa", f"USE {nome_banco}")

        for cmd in script.split(';'):
            if cmd.strip():
                cursor.execute(cmd)

        conn.commit()
        print(f"Banco '{nome_banco}' criado.")
    except Exception as e:
        print("Erro:", e)
    finally:
        cursor.close()
        conn.close()

def destruir_banco(user):
    nome_banco = input("Nome do banco a ser destruído: ").strip()
    try:
        conn = mysql.connector.connect(host='localhost', user=user, password=SENHAS[user])
        cursor = conn.cursor()
        cursor.execute(f"DROP DATABASE IF EXISTS {nome_banco}")
        conn.commit()
        print(f"Banco '{nome_banco}' destruído.")
    except Exception as e:
        print("Erro:", e)
    finally:
        cursor.close()
        conn.close()

def estatisticas(user, db):
    conn = conectar(user, SENHAS[user], db)
    if not conn:
        return
    cursor = conn.cursor()
    try:
        cursor.callproc('estatisticas')
        for result in cursor.stored_results():
            for row in result.fetchall():
                print(row)
    except Exception as e:
        print("Erro ao executar estatísticas:", e)
    finally:
        cursor.close()
        conn.close()

# ========== LOGIN ==========
def login():
    print("Login no sistema")
    usuario = input("Usuário (admin/gerente/funcionario): ")
    senha = getpass("Senha: ")
    if usuario in SENHAS and senha == SENHAS[usuario]:
        print(f"Bem-vindo, {usuario}!")
        menu(usuario)
    else:
        print("Credenciais inválidas.")

if __name__ == "__main__":
    login()
