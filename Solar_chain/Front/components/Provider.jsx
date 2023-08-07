"use client"
import React from 'react';
import { ThirdwebProvider } from '@thirdweb-dev/react'
import { Ethereum, Polygon, Goerli, Sepolia } from "@thirdweb-dev/chains";
import StateContextProvider from '@/context/Context.jsx';


export default function Provider({ children }) {
    return (
        <ThirdwebProvider autoConnect supportedChains={[ Sepolia]} activeChain={'sepolia'}>
            <StateContextProvider>

                {children}
            </StateContextProvider>
        </ThirdwebProvider>
    );
};
