#include "pch.h"
#include "prxdll.h"

BOOL APIENTRY DllMain(
    const HINSTANCE instance,
    const DWORD reason,
    const PVOID reserved)
{
    switch ( reason ) {
    case DLL_PROCESS_ATTACH:
        DisableThreadLibraryCalls(instance);
        return prx_attach(instance);
    case DLL_PROCESS_DETACH:
        prx_detach(reserved);
        break;
    }
    return TRUE;
}
