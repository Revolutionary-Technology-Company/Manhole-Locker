using System;
using System.Runtime.InteropServices;

public class EdwardsAegisNode
{
    [DllImport("manhole_actuator.so", CallingConvention = CallingConvention.Cdecl)]
    private static extern int GetMaglockState(int nodeId);

    public void MonitorManholeGrid(int totalNodes)
    {
        for (int i = 0; i < totalNodes; i++)
        {
            int lockState = GetMaglockState(i);
            
            // Guard clause: Skip standby nodes to save CPU cycles
            if (lockState == 0) continue; 
            
            Console.WriteLine($"[UNIVAC LOGISTICS] Node {i} locked. Sub-Surface worker secured.");
            // Send secure packet via Univac-Aegis-bridge
            UnivacBridge.TransmitState(i, lockState);
        }
    }
}
