# Configuração do UWF (Unified Write Filter) no Windows

Este repositório contém um script em lote (`.bat` / `.cmd`) para automatizar a configuração do **UWF (Unified Write Filter)** em sistemas Windows.

O UWF é um recurso do Windows (comumente usado em versões Enterprise e IoT) que protege os drives de armazenamento redirecionando todas as gravações para uma sobreposição de memória (RAM ou Disco), garantindo que o estado do sistema seja restaurado a cada reinicialização.

##  Avisos Importantes

1. **Reinicialização Imediata:** O script executa `shutdown /r /t 0` no final. A máquina será **reiniciada automaticamente** sem aviso prévio para aplicar as alterações. Salve seus trabalhos antes de executar.

2. **Privilégios Elevados:** O script exige permissões de **Administrador**.

3. **Requisitos de Sistema:** Recomendado para sistemas com **8 GB de RAM ou mais** quando utilizando o modo RAM (a sobreposição padrão é configurada para 4 GB).

## 🛠️ O que o script faz?

1. **Proteção do Volume:** Habilita a proteção de escrita no drive `C:`.

2. **Configuração de Overlay:**

   * Define o tipo de sobreposição para **RAM**.

   * Define o tamanho máximo para **4096 MB (4 GB)**.

   * Define alertas para **80%** (3277 MB) e **90%** (3686 MB) de uso da memória temporária.

3. **Exclusões do Sistema (Manutenção de Dados):**

   * Configurações de relógio e fuso horário.

   * Definições do **Windows Defender** (para garantir atualizações de vacina e logs).

   * Arquivos de log de atualização e downloads em segundo plano.

4. **Ativação do Filtro:** Ativa o serviço do UWF no sistema.

##  Como Usar

1. Baixe ou clone este repositório.

2. Clique com o botão direito no arquivo de script e selecione **"Executar como Administrador"**.

3. Aguarde o término do processo. O terminal exibirá o status atual e a máquina **reiniciará em seguida**.

##  Dicas de Customização

Se necessário, abra o script num editor de texto antes de executá-lo para ajustar:

* **Tamanho da RAM:** Mude o valor na linha `uwfmgr.exe overlay set-size 4096` de acordo com a memória disponível no seu dispositivo.

* **Alterar Tipo de Overlay (RAM para Disco):** Se a máquina tiver pouca memória RAM, você pode alterar o armazenamento temporário para o próprio disco substituindo a linha:
  ```cmd
  uwfmgr.exe overlay set-type RAM
  ```
  por:
  ```cmd
  uwfmgr.exe overlay set-type DISK
  ```

* **Desativar Auto-Reboot:** Comente ou remova a linha `shutdown /r /t 0` caso prefira reiniciar manualmente depois.

* **Exclusões Extras:** Adicione exceções para pastas de documentos ou programas específicos desmarcando ou inserindo novas linhas `file add-exclusion`.
