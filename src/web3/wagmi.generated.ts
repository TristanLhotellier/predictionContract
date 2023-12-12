import {
  Address,
  UseContractReadConfig,
  UseContractWriteConfig,
  UsePrepareContractWriteConfig,
  useContractRead,
  useContractWrite,
  usePrepareContractWrite,
} from 'wagmi';
import { PrepareWriteContractResult, ReadContractResult, WriteContractMode } from 'wagmi/actions';

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Motd
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * [__View Contract on Sepolia Etherscan__](https://sepolia.etherscan.io/address/0x98d49ccdf7b73b544f046d10d41453d5e753fb02)
 */
export const motdABI = [
  {
    stateMutability: 'nonpayable',
    type: 'constructor',
    inputs: [{ name: 'initial', internalType: 'string', type: 'string' }],
  },
  { type: 'error', inputs: [], name: 'OnlyOwner' },
  {
    stateMutability: 'view',
    type: 'function',
    inputs: [],
    name: 'message',
    outputs: [{ name: '', internalType: 'string', type: 'string' }],
  },
  {
    stateMutability: 'view',
    type: 'function',
    inputs: [],
    name: 'owner',
    outputs: [{ name: '', internalType: 'address', type: 'address' }],
  },
  {
    stateMutability: 'nonpayable',
    type: 'function',
    inputs: [{ name: 'newMessage', internalType: 'string', type: 'string' }],
    name: 'setMessage',
    outputs: [],
  },
  {
    stateMutability: 'nonpayable',
    type: 'function',
    inputs: [{ name: 'newOwner', internalType: 'address', type: 'address' }],
    name: 'transferOwnership',
    outputs: [],
  },
] as const;

/**
 * [__View Contract on Sepolia Etherscan__](https://sepolia.etherscan.io/address/0x98d49ccdf7b73b544f046d10d41453d5e753fb02)
 */
export const motdAddress = {
  11155111: '0x98d49ccdf7B73b544F046d10D41453d5e753Fb02',
} as const;

/**
 * [__View Contract on Sepolia Etherscan__](https://sepolia.etherscan.io/address/0x98d49ccdf7b73b544f046d10d41453d5e753fb02)
 */
export const motdConfig = { address: motdAddress, abi: motdABI } as const;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// React
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * Wraps __{@link useContractRead}__ with `abi` set to __{@link motdABI}__.
 *
 * [__View Contract on Sepolia Etherscan__](https://sepolia.etherscan.io/address/0x98d49ccdf7b73b544f046d10d41453d5e753fb02)
 */
export function useMotdRead<
  TFunctionName extends string,
  TSelectData = ReadContractResult<typeof motdABI, TFunctionName>,
>(
  config: Omit<UseContractReadConfig<typeof motdABI, TFunctionName, TSelectData>, 'abi' | 'address'> & {
    chainId?: keyof typeof motdAddress;
  } = {} as any,
) {
  return useContractRead({
    abi: motdABI,
    address: motdAddress[11155111],
    ...config,
  } as UseContractReadConfig<typeof motdABI, TFunctionName, TSelectData>);
}

/**
 * Wraps __{@link useContractRead}__ with `abi` set to __{@link motdABI}__ and `functionName` set to `"message"`.
 *
 * [__View Contract on Sepolia Etherscan__](https://sepolia.etherscan.io/address/0x98d49ccdf7b73b544f046d10d41453d5e753fb02)
 */
export function useMotdMessage<
  TFunctionName extends 'message',
  TSelectData = ReadContractResult<typeof motdABI, TFunctionName>,
>(
  config: Omit<
    UseContractReadConfig<typeof motdABI, TFunctionName, TSelectData>,
    'abi' | 'address' | 'functionName'
  > & { chainId?: keyof typeof motdAddress } = {} as any,
) {
  return useContractRead({
    abi: motdABI,
    address: motdAddress[11155111],
    functionName: 'message',
    ...config,
  } as UseContractReadConfig<typeof motdABI, TFunctionName, TSelectData>);
}

/**
 * Wraps __{@link useContractRead}__ with `abi` set to __{@link motdABI}__ and `functionName` set to `"owner"`.
 *
 * [__View Contract on Sepolia Etherscan__](https://sepolia.etherscan.io/address/0x98d49ccdf7b73b544f046d10d41453d5e753fb02)
 */
export function useMotdOwner<
  TFunctionName extends 'owner',
  TSelectData = ReadContractResult<typeof motdABI, TFunctionName>,
>(
  config: Omit<
    UseContractReadConfig<typeof motdABI, TFunctionName, TSelectData>,
    'abi' | 'address' | 'functionName'
  > & { chainId?: keyof typeof motdAddress } = {} as any,
) {
  return useContractRead({
    abi: motdABI,
    address: motdAddress[11155111],
    functionName: 'owner',
    ...config,
  } as UseContractReadConfig<typeof motdABI, TFunctionName, TSelectData>);
}

/**
 * Wraps __{@link useContractWrite}__ with `abi` set to __{@link motdABI}__.
 *
 * [__View Contract on Sepolia Etherscan__](https://sepolia.etherscan.io/address/0x98d49ccdf7b73b544f046d10d41453d5e753fb02)
 */
export function useMotdWrite<
  TFunctionName extends string,
  TMode extends WriteContractMode = undefined,
  TChainId extends number = keyof typeof motdAddress,
>(
  config: TMode extends 'prepared'
    ? UseContractWriteConfig<
        PrepareWriteContractResult<typeof motdABI, string>['request']['abi'],
        TFunctionName,
        TMode
      > & { address?: Address; chainId?: TChainId }
    : UseContractWriteConfig<typeof motdABI, TFunctionName, TMode> & {
        abi?: never;
        address?: never;
        chainId?: TChainId;
      } = {} as any,
) {
  return useContractWrite<typeof motdABI, TFunctionName, TMode>({
    abi: motdABI,
    address: motdAddress[11155111],
    ...config,
  } as any);
}

/**
 * Wraps __{@link useContractWrite}__ with `abi` set to __{@link motdABI}__ and `functionName` set to `"setMessage"`.
 *
 * [__View Contract on Sepolia Etherscan__](https://sepolia.etherscan.io/address/0x98d49ccdf7b73b544f046d10d41453d5e753fb02)
 */
export function useMotdSetMessage<
  TMode extends WriteContractMode = undefined,
  TChainId extends number = keyof typeof motdAddress,
>(
  config: TMode extends 'prepared'
    ? UseContractWriteConfig<
        PrepareWriteContractResult<typeof motdABI, 'setMessage'>['request']['abi'],
        'setMessage',
        TMode
      > & { address?: Address; chainId?: TChainId; functionName?: 'setMessage' }
    : UseContractWriteConfig<typeof motdABI, 'setMessage', TMode> & {
        abi?: never;
        address?: never;
        chainId?: TChainId;
        functionName?: 'setMessage';
      } = {} as any,
) {
  return useContractWrite<typeof motdABI, 'setMessage', TMode>({
    abi: motdABI,
    address: motdAddress[11155111],
    functionName: 'setMessage',
    ...config,
  } as any);
}

/**
 * Wraps __{@link useContractWrite}__ with `abi` set to __{@link motdABI}__ and `functionName` set to `"transferOwnership"`.
 *
 * [__View Contract on Sepolia Etherscan__](https://sepolia.etherscan.io/address/0x98d49ccdf7b73b544f046d10d41453d5e753fb02)
 */
export function useMotdTransferOwnership<
  TMode extends WriteContractMode = undefined,
  TChainId extends number = keyof typeof motdAddress,
>(
  config: TMode extends 'prepared'
    ? UseContractWriteConfig<
        PrepareWriteContractResult<typeof motdABI, 'transferOwnership'>['request']['abi'],
        'transferOwnership',
        TMode
      > & {
        address?: Address;
        chainId?: TChainId;
        functionName?: 'transferOwnership';
      }
    : UseContractWriteConfig<typeof motdABI, 'transferOwnership', TMode> & {
        abi?: never;
        address?: never;
        chainId?: TChainId;
        functionName?: 'transferOwnership';
      } = {} as any,
) {
  return useContractWrite<typeof motdABI, 'transferOwnership', TMode>({
    abi: motdABI,
    address: motdAddress[11155111],
    functionName: 'transferOwnership',
    ...config,
  } as any);
}

/**
 * Wraps __{@link usePrepareContractWrite}__ with `abi` set to __{@link motdABI}__.
 *
 * [__View Contract on Sepolia Etherscan__](https://sepolia.etherscan.io/address/0x98d49ccdf7b73b544f046d10d41453d5e753fb02)
 */
export function usePrepareMotdWrite<TFunctionName extends string>(
  config: Omit<UsePrepareContractWriteConfig<typeof motdABI, TFunctionName>, 'abi' | 'address'> & {
    chainId?: keyof typeof motdAddress;
  } = {} as any,
) {
  return usePrepareContractWrite({
    abi: motdABI,
    address: motdAddress[11155111],
    ...config,
  } as UsePrepareContractWriteConfig<typeof motdABI, TFunctionName>);
}

/**
 * Wraps __{@link usePrepareContractWrite}__ with `abi` set to __{@link motdABI}__ and `functionName` set to `"setMessage"`.
 *
 * [__View Contract on Sepolia Etherscan__](https://sepolia.etherscan.io/address/0x98d49ccdf7b73b544f046d10d41453d5e753fb02)
 */
export function usePrepareMotdSetMessage(
  config: Omit<UsePrepareContractWriteConfig<typeof motdABI, 'setMessage'>, 'abi' | 'address' | 'functionName'> & {
    chainId?: keyof typeof motdAddress;
  } = {} as any,
) {
  return usePrepareContractWrite({
    abi: motdABI,
    address: motdAddress[11155111],
    functionName: 'setMessage',
    ...config,
  } as UsePrepareContractWriteConfig<typeof motdABI, 'setMessage'>);
}

/**
 * Wraps __{@link usePrepareContractWrite}__ with `abi` set to __{@link motdABI}__ and `functionName` set to `"transferOwnership"`.
 *
 * [__View Contract on Sepolia Etherscan__](https://sepolia.etherscan.io/address/0x98d49ccdf7b73b544f046d10d41453d5e753fb02)
 */
export function usePrepareMotdTransferOwnership(
  config: Omit<
    UsePrepareContractWriteConfig<typeof motdABI, 'transferOwnership'>,
    'abi' | 'address' | 'functionName'
  > & { chainId?: keyof typeof motdAddress } = {} as any,
) {
  return usePrepareContractWrite({
    abi: motdABI,
    address: motdAddress[11155111],
    functionName: 'transferOwnership',
    ...config,
  } as UsePrepareContractWriteConfig<typeof motdABI, 'transferOwnership'>);
}
