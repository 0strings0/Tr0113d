ifndef _M_X64
    .model flat
else
    include ksamd64.inc
endif

ifndef _M_X64
    prx_find_function proto stdcall, arg1:word, arg2:dword
else
    extern prx_find_function:proc
endif

PRX_EXPORT32 macro langtype:req, procname:req, ordinal:req
    .erre ordinal

    ifndef _M_X64
        .data
        procname&_ptr dd 0

        .code
        procname proc langtype
            mov eax, procname&_ptr
            test eax, eax
            jnz skip_find
                invoke prx_find_function, ordinal, offset procname&_ptr

        skip_find:
            jmp eax
        procname endp
    endif
endm

PRX_EXPORT64 macro procname:req, ordinal:req
    .erre ordinal

    ifdef _M_X64
        .data
        procname&_ptr dq 0

        .code
        procname proc frame
            save_reg r9, 20h
            save_reg r8, 18h
            save_reg rdx, 10h
            save_reg rcx, 8
            alloc_stack 28h
            END_PROLOGUE
            
            mov rax, procname&_ptr
            test rax, rax
            jnz skip_find
                mov rcx, ordinal
                mov rdx, offset procname&_ptr
                call prx_find_function

        skip_find:
            add rsp, 28h
            mov rcx, [rsp + 8]
            mov rdx, [rsp + 10h]
            mov r8, [rsp + 18h]
            mov r9, [rsp + 20h]
            
            BEGIN_EPILOGUE
            rex_jmp_reg rax
        procname endp
    endif
endm

PRX_EXPORT macro langtype:req, procname:req, ordinal1:req, ordinal2
    PRX_EXPORT32 langtype, procname, ordinal1
    
    ifb <ordinal2>
        PRX_EXPORT64 procname, ordinal1
    else
        PRX_EXPORT64 procname, ordinal2
    endif
endm

PRX_EXPORT stdcall, D3DKMTCloseAdapter, 1
PRX_EXPORT stdcall, D3DKMTDestroyAllocation, 2
PRX_EXPORT stdcall, D3DKMTDestroyContext, 3
PRX_EXPORT stdcall, D3DKMTDestroyDevice, 4
PRX_EXPORT stdcall, D3DKMTDestroySynchronizationObject, 5
PRX_EXPORT stdcall, D3DKMTQueryAdapterInfo, 6
PRX_EXPORT stdcall, D3DKMTSetDisplayPrivateDriverFormat, 7
PRX_EXPORT stdcall, D3DKMTSignalSynchronizationObject, 8
PRX_EXPORT stdcall, D3DKMTUnlock, 9
PRX_EXPORT stdcall, D3DKMTWaitForSynchronizationObject, 10
PRX_EXPORT stdcall, EnableFeatureLevelUpgrade, 11
PRX_EXPORT stdcall, OpenAdapter10, 12
PRX_EXPORT stdcall, OpenAdapter10_2, 13
PRX_EXPORT stdcall, D3D11CoreCreateDevice, 14
PRX_EXPORT stdcall, D3D11CoreCreateLayeredDevice, 15
PRX_EXPORT stdcall, D3D11CoreGetLayeredDeviceSize, 16
PRX_EXPORT stdcall, D3D11CoreRegisterLayers, 17
PRX_EXPORT stdcall, D3D11CreateDevice, 18
PRX_EXPORT stdcall, D3D11CreateDeviceAndSwapChain, 19
PRX_EXPORT stdcall, D3DKMTCreateAllocation, 20
PRX_EXPORT stdcall, D3DKMTCreateContext, 21
PRX_EXPORT stdcall, D3DKMTCreateDevice, 22
PRX_EXPORT stdcall, D3DKMTCreateSynchronizationObject, 23
PRX_EXPORT stdcall, D3DKMTEscape, 24
PRX_EXPORT stdcall, D3DKMTGetContextSchedulingPriority, 25
PRX_EXPORT stdcall, D3DKMTGetDeviceState, 26
PRX_EXPORT stdcall, D3DKMTGetDisplayModeList, 27
PRX_EXPORT stdcall, D3DKMTGetMultisampleMethodList, 28
PRX_EXPORT stdcall, D3DKMTGetRuntimeData, 29
PRX_EXPORT stdcall, D3DKMTGetSharedPrimaryHandle, 30
PRX_EXPORT stdcall, D3DKMTLock, 31
PRX_EXPORT stdcall, D3DKMTOpenAdapterFromHdc, 32
PRX_EXPORT stdcall, D3DKMTOpenResource, 33
PRX_EXPORT stdcall, D3DKMTPresent, 34
PRX_EXPORT stdcall, D3DKMTQueryAllocationResidency, 35
PRX_EXPORT stdcall, D3DKMTQueryResourceInfo, 36
PRX_EXPORT stdcall, D3DKMTRender, 37
PRX_EXPORT stdcall, D3DKMTSetAllocationPriority, 38
PRX_EXPORT stdcall, D3DKMTSetContextSchedulingPriority, 39
PRX_EXPORT stdcall, D3DKMTSetDisplayMode, 40
PRX_EXPORT stdcall, D3DKMTSetGammaRamp, 41
PRX_EXPORT stdcall, D3DKMTSetVidPnSourceOwner, 42
PRX_EXPORT stdcall, D3DKMTWaitForVerticalBlankEvent, 43
PRX_EXPORT stdcall, D3DPerformance_BeginEvent, 44
PRX_EXPORT stdcall, D3DPerformance_EndEvent, 45
PRX_EXPORT stdcall, D3DPerformance_GetStatus, 46
PRX_EXPORT stdcall, D3DPerformance_SetMarker, 47

end
