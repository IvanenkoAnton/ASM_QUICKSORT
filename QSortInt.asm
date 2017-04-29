;Anton Ivanenko, January 2017
;ASM Procedure realisation
.686
.model flat,C

.code
QSortInt proc 
	push ebp
	mov ebp, esp
	sub esp, 12

	mov edi, [ebp + 8];mas
	mov ebx, [ebp + 12];left
	mov ecx, [ebp + 16];right

	mov [ebp - 4],ebx ; i
	mov [ebp - 8],ecx ; j

	add ebx,ecx
	shr ebx,1

	mov eax, dword ptr [edi + ebx*4]
	mov [ebp - 12], eax ; tmp

	jmp while_cmp
while_whole:

	jmp while_cmp_1
while_first:
	mov ebx,[ebp - 4]
	inc ebx
	mov [ebp - 4],ebx

while_cmp_1:
	mov ebx,[ebp - 4]
	mov eax, dword ptr[edi + ebx*4]
	mov ecx, [ebp - 12]
	cmp eax,ecx
	jl while_first

	jmp while_cmp_2
while_second:
	mov ebx,[ebp - 8]
	dec ebx
	mov [ebp - 8],ebx

while_cmp_2:
	mov ebx, [ebp - 8]
	mov eax, dword ptr[edi + ebx*4]
	mov ecx, [ebp - 12]
	cmp eax, ecx
	jg while_second

   	mov ebx, [ebp - 4]
	mov ecx, [ebp - 8]
	cmp ebx,ecx
	jg while_cmp
	mov eax, dword ptr [edi + ebx*4]
	mov edx, dword ptr [edi + ecx*4]
	mov dword ptr [edi + ebx*4], edx
	mov dword ptr [edi + ecx*4], eax
	inc ebx
	dec ecx
	mov [ebp - 4], ebx
	mov [ebp - 8], ecx

while_cmp:
	mov ebx,[ebp - 4]
	mov ecx,[ebp - 8]
	cmp ebx,ecx
	jle while_whole

	mov ebx, [ebp - 4]
	mov ecx, [ebp + 16]
	cmp ebx, ecx
	jge next
	mov edi, [ebp + 8]
	push ecx
	push ebx
	push edi
	call QSortInt 
	add esp,12

next:
	mov ebx, [ebp - 8]
	mov ecx, [ebp + 12]
	cmp ebx, ecx
	jle label_end
	mov edi, [ebp + 8]
	push ebx
	push ecx
	push edi
	call QSortInt 
	add esp,12

label_end:
    
	add esp,12
	pop ebp
	ret 
QSortInt endp
end

