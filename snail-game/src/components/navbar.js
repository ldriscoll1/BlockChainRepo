import styles from "../styles/Home.module.css";
import Link from "next/link";

export function Navbar() {
	return (
		<div className={styles.navbar}>
			<ul>
				<li>
					<Link href="/">Snail Race</Link>
				</li>
				<li>
					<Link href="/Leaderboard">Leaderboard</Link>
				</li>
				<li>
					<Link href="/MoreInfo">More Info</Link>
				</li>
			</ul>
		</div>
	);
}
