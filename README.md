
# 📖 Recipe App

Aplicativo de receitas desenvolvido em **Flutter** com suporte a **Web** e **Mobile (Android/iOS)**, utilizando **Firebase Authentication** para login e registro de usuários.

---

## ✨ Funcionalidades
- Registro e login de usuários com autenticação Firebase.
- Visualização de receitas salvas.
- Suporte para plataforma Web, Android e iOS.
- Design simples e amigável.
- Salvamento de imagens e receitas.

---

## 🛠️ Tecnologias Utilizadas
- [Flutter](https://flutter.dev/) 3.x
- [Dart](https://dart.dev/)
- [Firebase Authentication](https://firebase.google.com/)
- [Firebase Core](https://firebase.google.com/)
- Plataforma Android, iOS e Web.

---

## 🚀 Como executar o projeto

1. **Clone o repositório**
   ```bash
   git clone https://github.com/seu-usuario/nome-do-repositorio.git
   cd nome-do-repositorio
   ```

2. **Instale as dependências**
   ```bash
   flutter pub get
   ```

3. **Configure o Firebase**
   - Configure os arquivos `google-services.json` (Android) e `GoogleService-Info.plist` (iOS).
   - O projeto já inclui `firebase_options.dart` gerado.

4. **Execute o app**
   ```bash
   flutter run
   ```

---

## 📂 Estrutura do Projeto

```
lib/
 ├── main.dart               # Ponto de entrada do app
 ├── login_page.dart          # Página de login
 ├── register_page.dart       # Página de registro
 └── recipes_page.dart        # Página de visualização de receitas
assets/
 └── chef.png                 # Imagem usada no app
```
