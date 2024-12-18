bits 64

section .data
    message db "Entre ton nom : ", 10
    messagedeux db "Bonjour ", 0
    buffer_size equ 64
    newline db 10, 0

section .bss
    buffer resb buffer_size ; Allocation de 64 octets pour le buffer
    output resb 128 ; Allocation de 128 octets pour l'output final

section .text
    global _start
    _start:
        ; Afficher le message 
        mov rax, 1                        ; write
        mov rdi, 1                        ; stdout
        mov rsi, message                  ; message: "Entre ton nom : "
        mov rdx, 15                       ; Longueur de "Entre ton nom : " + newline
        syscall

        ; Lire l'entrée utilisateur
        mov rax, 0                        ; read
        mov rdi, 0                        ; stdin
        mov rsi, buffer                   ; Adresse du buffer utilisateur
        mov rdx, buffer_size              ; Taille du buffer
        syscall

        ; Retirer le saut de ligne de l'entrée utilisateur
        mov rdi, buffer                   ; Adresse du buffer
        call remove_newline

        ; Construire le message "Bonjour [Nom]"
        mov rdi, messagedeux              ; "Bonjour "
        mov rsi, buffer                   ; Entrée utilisateur
        mov rdx, output                   ; Buffer pour l'output
        call concat_strings

        ; Calculer la longueur réelle de la chaîne concaténée
        mov rsi, output
        xor rdx, rdx                      ; Compteur de longueur (rdx = 0)
.calc_length:
        cmp byte [rsi + rdx], 0           ; Trouver le caractère null
        je .write_output                  ; Si trouvé, écrire la chaîne
        inc rdx                           ; Avancer d'un caractère
        jmp .calc_length

    .write_output:
        ; Afficher le message final
        mov rax, 1                        ; write
        mov rdi, 1                        ; stdout
        mov rsi, output                   ; Message à afficher
        syscall

        ; Terminer le programme
        mov rax, 60                       ; exit
        mov rdi, 0                        ; Code de retour 0
        syscall

remove_newline:
    mov rcx, buffer_size
.next_char:
    cmp byte [rdi], 0                     ; Fin de la chaîne ?
    je .done                              ; Si oui, terminer
    cmp byte [rdi], 10                    ; Trouvé \n ?
    jne .continue                         ; Si non, continuer
    mov byte [rdi], 0                     ; Remplacer \n par null
    jmp .done                             ; Terminer
.continue:
    inc rdi                               ; Avancer d'un caractère
    loop .next_char
.done:
    ret

concat_strings:
    push rdi                              ; Sauvegarder les registres
    push rsi
    push rdx
.loop_messagedeux:
    mov al, [rdi]                         ; Charger chaque caractère de "Bonjour "
    cmp al, 0                             ; Fin de "Bonjour " ?
    je .loop_name                         ; Passer à la chaîne suivante
    mov [rdx], al                         ; Copier dans output
    inc rdi
    inc rdx
    jmp .loop_messagedeux
.loop_name:
    mov al, [rsi]                         ; Charger chaque caractère du nom
    cmp al, 0                             ; Fin du nom ?
    je .finalize                          ; Si oui, terminer
    mov [rdx], al                         ; Copier dans output
    inc rsi
    inc rdx
    jmp .loop_name
.finalize:
    mov byte [rdx], 10                    ; Ajouter un saut de ligne final
    inc rdx                               ; Terminateur null
    mov byte [rdx], 0
    pop rdx                               ; Restaurer les registres
    pop rsi
    pop rdi
    ret
