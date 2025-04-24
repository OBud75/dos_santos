section .data
    prompt db "Entre ton nom: ", 0     ; Le message d'invite
    greeting db "Bonjour, ", 0        ; Le début de l'affichage
    name db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ; Variable pour le nom (taille max 10 caractères)
    newline db 10, 0                  ; Retour à la ligne

section .bss
    name_length resb 10               ; Réserve 10 octets pour stocker le nom

section .text
    global _start

_start:
    ; Afficher "Entre ton nom: "
    mov rax, 1            ; Syscall: write
    mov rdi, 1            ; STDOUT
    mov rsi, prompt       ; Message à afficher
    mov rdx, 15           ; Taille du message
    syscall

    ; Lire l'entrée utilisateur
    mov rax, 0            ; Syscall: read
    mov rdi, 0            ; STDIN
    mov rsi, name         ; Adresse du buffer où stocker le nom
    mov rdx, 10           ; Nombre max de caractères à lire
    syscall

    ; Ajouter null terminator (remplace le '\n')
    mov rsi, name
    mov rcx, 10           ; Max: taille de la chaîne lue
.loop:
    cmp byte [rsi], 10     ; Vérifier si '\n'
    je .end_of_input       ; Si oui, fin
    cmp byte [rsi], 0      ; Vérifier si c’est déjà null
    je .end_of_input       ; Fin de l'entrée
    inc rsi                ; Passer au caractère suivant
    loop .loop
.end_of_input:
    mov byte [rsi], 0      ; Mettre '\0' à la fin de la chaîne

    ; Afficher "Bonjour, "
    mov rax, 1            ; Syscall: write
    mov rdi, 1            ; STDOUT
    mov rsi, greeting     ; Message "Bonjour, "
    mov rdx, 9            ; Taille du message
    syscall

    ; Afficher le nom
    mov rax, 1            ; Syscall: write
    mov rdi, 1            ; STDOUT
    mov rsi, name         ; Adresse du buffer contenant le nom
    mov rdx, 10           ; Taille maximale du nom
    syscall

    ; Afficher le saut de ligne
    mov rax, 1            ; Syscall: write
    mov rdi, 1            ; STDOUT
    mov rsi, newline      ; Adresse de la ligne vide
    mov rdx, 2            ; Taille (1 caractère)
    syscall

    ; Sortir proprement
    mov rax, 60           ; Syscall: exit
    xor rdi, rdi          ; Code de sortie 0
    syscall

; Vous pouvez créer des fonction (par exemple exit, newline, get_input ...)