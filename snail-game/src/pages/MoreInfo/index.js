import styles from '../../styles/Home.module.css';
export default function MoreInfo() {
	return (
		<div className={styles.MoreInfo}>
			<h1>Resources</h1>
			<ul>
				<li><a href="https://docs.soliditylang.org/en/v0.8.6/">Solidity Documentation</a></li>
				<li><a href="https://info.etherscan.com/how-to-use-read-or-write-contract-features-on-etherscan/">How to Use Read or Write Contract Features on Etherscan</a></li>
				<li><a href="https://nextjs.org/docs">Nextjs Documentation</a></li>
				<li><a href="https://docs.etherscan.io/tutorials/read-write-smart-contracts">Read/Write Smart Contracts through Etherscan API</a></li>
			</ul>
		</div>
	);
}
