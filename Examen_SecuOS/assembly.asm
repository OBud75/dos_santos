section .data
    prompt db "Entre ton nom: ", 0     ; Texte pour demander le nom
    greeting db "Bonjour, ", 0        ; Texte pour dire bonjour
    name db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ; Réserve de mémoire pour le nom
    newline db 10, 0                  ; Ligne vide

section .bss
    name_length resb 10               ; Mémoire pour stocker le nom

section .text
    global _start

_start:
    ; Affiche le message pour demander le nom
    mov rax, 1            ; Appel système write
    mov rdi, 1            ; Écrit sur l'écran (stdout)
    mov rsi, prompt       ; Le texte à afficher
    mov rdx, 15           ; Longueur du texte
    syscall

    ; Lit ce que l'utilisateur tape
    mov rax, 0            ; Appel système read
    mov rdi, 0            ; Lit l'entrée clavier (stdin)
    mov rsi, name         ; Met le texte dans name
    mov rdx, 10           ; Max 10 caractères
    syscall

    ; Remplace le '\n' à la fin par un 0 pour finir la chaîne
    mov rsi, name
    mov rcx, 10           ; Boucle pour trouver '\n'
.loop:
    cmp byte [rsi], 10     ; Si c'est '\n'
    je .end_of_input       ; On a trouvé, on stop
    cmp byte [rsi], 0      ; Si c'est déjà 0
    je .end_of_input       ; C'est fini
    inc rsi                ; Passer au caractère suivant
    loop .loop
.end_of_input:
    mov byte [rsi], 0      ; Ajoute un 0 à la fin

    ; Affiche "Bonjour, "
    mov rax, 1            ; Appel système write
    mov rdi, 1            ; Écrit sur l'écran (stdout)
    mov rsi, greeting     ; Le texte "Bonjour, "
    mov rdx, 9            ; Taille
    syscall

    ; Affiche le nom
    mov rax, 1            ; Appel système write
    mov rdi, 1            ; Écrit sur l'écran (stdout)
    mov rsi, name         ; Affiche le nom tapé
    mov rdx, 10           ; Taille max du nom
    syscall

    ; Affiche une ligne vide
    mov rax, 1            ; Appel système write
    mov rdi, 1            ; Écrit sur l'écran (stdout)
    mov rsi, newline      ; Ligne vide
    mov rdx, 2            ; Taille (1 caractère)
    syscall

    ; Fin du programme
    mov rax, 60           ; Appel système exit
    xor rdi, rdi          ; Code de sortie 0
    syscall
